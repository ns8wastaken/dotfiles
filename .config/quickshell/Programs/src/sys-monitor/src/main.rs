use nvml_wrapper::Nvml;
use nvml_wrapper::enum_wrappers::device::TemperatureSensor;
use serde::Serialize;
use std::fs;
use std::io::{BufWriter, Write};
use std::thread::sleep;
use std::time::{Duration, Instant};
use sysinfo::{Components, CpuRefreshKind, Disks, MemoryRefreshKind, Networks, RefreshKind, System};

const KB: u64 = 1024;
const MB: u64 = 1024 * 1024;
const GB: u64 = 1024 * 1024 * 1024;

#[inline(always)]
fn round1(x: f32) -> f32 {
    (x * 10.0).round() / 10.0
}

// --- Types ---------------------------------------------------------------------

#[derive(Serialize)]
struct Cpu {
    percent: f32,
    temp: f32,
}

#[derive(Serialize)]
struct Gpu {
    percent: Option<u32>,
    temp: Option<u32>,
    vram_used: Option<u64>,
    vram_total: Option<u64>,
}

#[derive(Serialize)]
struct Ram {
    used_mb: u64,
    total_mb: u64,
    swap_used_mb: u64,
    swap_total_mb: u64,
}

#[derive(Serialize)]
struct Disk {
    used_gb: u64,
    total_gb: u64,
}

#[derive(Serialize)]
struct Network {
    rx_kbps: u64,
    tx_kbps: u64,
}

#[derive(Serialize)]
struct SystemMetrics {
    cpu: Cpu,
    gpu: Gpu,
    ram: Ram,
    disk: Option<Disk>,
    network: Network,
}

// --- Collector -----------------------------------------------------------------

struct Collector {
    sys: System,
    networks: Networks,
    disks: Disks,
    components: Components,
    nvml_device: Option<nvml_wrapper::device::Device<'static>>,
    core_indices: Vec<usize>,
    interval_ms: u64,
    refresh_kind: RefreshKind,
}

impl Collector {
    fn new(interval: Duration) -> Self {
        let refresh_kind = RefreshKind::nothing()
            .with_cpu(CpuRefreshKind::nothing().with_cpu_usage())
            .with_memory(MemoryRefreshKind::everything());

        let nvml_device = if let Ok(nvml) = Nvml::init() {
            let leaked_nvml: &'static Nvml = Box::leak(Box::new(nvml));
            leaked_nvml.device_by_index(0).ok()
        } else {
            None
        };

        let components = Components::new_with_refreshed_list();

        let core_indices: Vec<usize> = components
            .iter()
            .enumerate()
            .filter(|(_, c)| is_core_label(c.label()))
            .map(|(i, _)| i)
            .collect();

        Self {
            sys: System::new(),
            networks: Networks::new(),
            disks: Disks::new(),
            components,
            nvml_device,
            core_indices,
            interval_ms: interval.as_millis() as u64,
            refresh_kind,
        }
    }

    fn refresh(&mut self) {
        self.sys.refresh_specifics(self.refresh_kind);
        self.networks.refresh(true);    // true: prune dead interfaces (WiFi/VPN can drop)
        self.disks.refresh(false);      // false: skip stale-entry scan - disks don't hotplug
        self.components.refresh(false); // false: CPU sensors are static - no scan needed
    }

    fn collect(&self) -> SystemMetrics {
        SystemMetrics {
            cpu: self.cpu(),
            gpu: self.gpu(),
            ram: self.ram(),
            disk: self.disk(),
            network: self.network(),
        }
    }

    fn cpu(&self) -> Cpu {
        let cpus = self.sys.cpus();
        let percent = if cpus.is_empty() {
            0.0
        } else {
            round1(
                cpus.iter()
                    .map(|c| c.cpu_usage())
                    .sum::<f32>() / cpus.len() as f32
            )
        };

        let list = self.components.list();
        let (sum, count) = self.core_indices
            .iter()
            .filter_map(|&idx| list.get(idx).and_then(|c| c.temperature()))
            .fold((0.0f32, 0usize), |(sum, n), t| (sum + t, n + 1));

        let temp = if count > 0 {
            round1(sum / count as f32)
        } else {
            0.0
        };

        Cpu { percent: round1(percent), temp }
    }

    fn gpu(&self) -> Gpu {
        // Try NVIDIA first via NVML
        if let Some(device) = &self.nvml_device {
            let percent = device.utilization_rates()
                .map(|u| u.gpu)
                .ok();

            let temp = device
                .temperature(TemperatureSensor::Gpu)
                .ok();

            let (vram_used, vram_total) = device.memory_info().ok()
                .map(|mem| (Some(mem.used), Some(mem.total)))
                .unwrap_or((None, None));

            return Gpu { percent, temp, vram_used, vram_total };
        }

        // AMD fallback via sysfs
        let percent = fs::read_to_string("/sys/class/drm/card0/device/gpu_busy_percent")
            .ok()
            .and_then(|v| v.trim().parse().ok());

        // NOTE: hwmon index may vary per system
        let temp = fs::read_to_string("/sys/class/drm/card0/device/hwmon/hwmon0/temp1_input")
            .ok()
            .and_then(|v| v.trim().parse::<u32>().ok())
            .map(|milli_c| milli_c / 1000);

        // Fetch AMD VRAM metrics
        let vram_used = fs::read_to_string("/sys/class/drm/card0/device/mem_info_vram_used")
            .ok()
            .and_then(|v| v.trim().parse::<u64>().ok());

        let vram_total = fs::read_to_string("/sys/class/drm/card0/device/mem_info_vram_total")
            .ok()
            .and_then(|v| v.trim().parse::<u64>().ok());

        Gpu { percent, temp, vram_used, vram_total }
    }

    fn ram(&self) -> Ram {
        Ram {
            used_mb: self.sys.used_memory() / MB,
            total_mb: self.sys.total_memory() / MB,
            swap_used_mb: self.sys.used_swap() / MB,
            swap_total_mb: self.sys.total_swap() / MB,
        }
    }

    fn disk(&self) -> Option<Disk> {
        self.disks.list().first().map_or(
            None,
            |d| {
                let total_gb = d.total_space() / GB;
                let free_gb = d.available_space() / GB;
                Some(Disk {
                    total_gb,
                    used_gb: total_gb.saturating_sub(free_gb)
                })
            },
        )
    }

    fn network(&self) -> Network {
        let (rx, tx) = self
            .networks
            .iter()
            .fold((0u64, 0u64), |(rx, tx), (_, d)| (rx + d.received(), tx + d.transmitted()));

        Network {
            rx_kbps: rx * 1000 / (self.interval_ms * KB),
            tx_kbps: tx * 1000 / (self.interval_ms * KB),
        }
    }
}

// --- Helpers -------------------------------------------------------------------

/// Case-insensitive substring match for "core" without any heap allocation.
/// Matches "Core 0", "Core 1", "coretemp Package id 0", etc.
#[inline]
fn is_core_label(label: &str) -> bool {
    label.as_bytes().windows(4).any(|w| {
        matches!(w, [b'c' | b'C', b'o' | b'O', b'r' | b'R', b'e' | b'E'])
    })
}

// --- Entry point ---------------------------------------------------------------

fn main() {
    let user_ms: u64 = std::env::args()
        .nth(1)
        .and_then(|s| s.parse().ok())
        .unwrap_or(1000);

    let min_ms = sysinfo::MINIMUM_CPU_UPDATE_INTERVAL.as_millis() as u64;
    let interval = Duration::from_millis(min_ms.max(user_ms));

    let mut collector = Collector::new(interval);

    // Acquire the stdout lock once for the lifetime of the process, and wrap it
    // in a BufWriter so write_all + flush is one syscall instead of two per tick.
    let stdout = std::io::stdout();
    let mut out = BufWriter::new(stdout.lock());

    // Reuse a single Vec<u8> as the JSON write target; clear() keeps the capacity,
    // so after the first tick there are zero heap allocations in the write path.
    let mut buf: Vec<u8> = Vec::with_capacity(512);

    loop {
        let start = Instant::now();
        collector.refresh();

        buf.clear();
        if serde_json::to_writer(&mut buf, &collector.collect()).is_ok() {
            buf.push(b'\n');
            let _ = out.write_all(&buf);
            let _ = out.flush();
        }

        let elapsed = start.elapsed();
        if elapsed < interval {
            sleep(interval - elapsed);
        }
    }
}

use std::env;
use std::path::Path;
use std::process::{Command, ExitStatus};

fn show_usage() -> ! {
    eprintln!("Usage: wallpaper_setter -w /path/to/image [-l]");
    std::process::exit(1);
}

fn notify(summary: &str, body: &str, critical: bool) {
    let mut cmd = Command::new("notify-send");
    if critical {
        cmd.arg("-u").arg("critical");
    }
    let _ = cmd.arg(summary).arg(body).status();
}

fn set_wallpaper(wallpaper: &str) -> std::io::Result<ExitStatus> {
    Command::new("swww")
        .arg("img")
        .arg(wallpaper)
        .arg("--transition-type").arg("any")
        .arg("--transition-duration").arg("1.5")
        .arg("--transition-step").arg("20")
        .arg("--transition-fps").arg("144")
        .status()
}

fn generate_theme(wallpaper: &str, light_mode: bool) -> std::io::Result<ExitStatus> {
    let mut cmd = Command::new("matugen");
    cmd.arg("image").arg(wallpaper);

    if light_mode {
        cmd.arg("-m").arg("light");
    }

    cmd.status()
}

fn main() {
    let mut args = env::args().skip(1);

    let mut wallpaper: Option<String> = None;
    let mut light_mode = false;

    while let Some(arg) = args.next() {
        match arg.as_str() {
            "-w" => wallpaper = args.next(),
            "-l" | "--light" => light_mode = true,
            _ => show_usage(),
        }
    }

    let wallpaper = wallpaper.unwrap_or_else(|| show_usage());

    if !Path::new(&wallpaper).is_file() {
        notify("Wallpaper", &format!("File does not exist: {}", wallpaper), true);
        std::process::exit(1);
    }

    if set_wallpaper(&wallpaper)
        .map(|s| s.success())
        .unwrap_or(false)
    {
        if generate_theme(&wallpaper, light_mode)
            .map(|s| !s.success())
            .unwrap_or(false)
        {
            notify("Wallpaper", "Failed to generate theme with matugen", true);
            std::process::exit(1);
        }
        notify("Wallpaper set", &wallpaper, false);
    } else {
        notify("Wallpaper", "swww failed to set the wallpaper", true);
        std::process::exit(1);
    }
}

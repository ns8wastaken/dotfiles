use std::env;
use std::path::Path;
use std::process::{Command, ExitStatus};

fn show_usage() -> ! {
    eprintln!("Usage: wallpaperctl -w /path/to/image [-l|--light]");
    eprintln!("Options:");
    eprintln!("  -w <path>      Path to wallpaper image (required)");
    eprintln!("  -l, --light    Use light mode theme");
    eprintln!("  -h, --help     Show this message");
    std::process::exit(1);
}

fn notify(summary: &str, body: &str, critical: bool) {
    let mut cmd = Command::new("notify-send");
    if critical {
        cmd.arg("-u").arg("critical");
    }
    if cmd.arg(summary).arg(body).status().is_err() {
        eprintln!("[{summary}] {body}");
    }
}

fn set_wallpaper(wallpaper: &str) -> std::io::Result<ExitStatus> {
    Command::new("awww")
        .args(["img", wallpaper])
        .args(["--transition-type", "any"])
        .args(["--transition-duration", "0.5"])
        .args(["--transition-step", "20"])
        .args(["--transition-fps", "144"])
        .status()
}

fn generate_theme(wallpaper: &str, light_mode: bool) -> std::io::Result<ExitStatus> {
    let mut cmd = Command::new("matugen");
    cmd.args(["image", wallpaper]);
    cmd.args(["--source-color-index", "0"]);

    if light_mode {
        cmd.args(["-m", "light"]);
    }

    cmd.status()
}

fn run() -> Result<(), String> {
    let mut args = env::args().skip(1);
    let mut wallpaper: Option<String> = None;
    let mut light_mode = false;

    while let Some(arg) = args.next() {
        match arg.as_str() {
            "-w" => {
                wallpaper = Some(args.next().unwrap_or_else(|| {
                    eprintln!("Error: -w requires a path argument");
                    show_usage();
                }));
            }
            "-l" | "--light" => light_mode = true,
            "-h" | "--help" => show_usage(),
            _ => show_usage(),
        }
    }

    let wallpaper = wallpaper.unwrap_or_else(|| show_usage());

    if !Path::new(&wallpaper).is_file() {
        return Err(format!("File does not exist: {wallpaper}"));
    }

    let wallpaper_set = set_wallpaper(&wallpaper)
        .map_err(|e| format!("Failed to launch awww: {e}"))?
        .success();

    if !wallpaper_set {
        return Err("awww failed to set the wallpaper".to_string());
    }

    let theme_generated = generate_theme(&wallpaper, light_mode)
        .map_err(|e| format!("Failed to launch matugen: {e}"))?
        .success();

    if !theme_generated {
        return Err("Failed to generate theme with matugen".to_string());
    }

    notify("Wallpaper set", &wallpaper, false);
    Ok(())
}

fn main() {
    if let Err(e) = run() {
        notify("Wallpaper", &e, true);
        std::process::exit(1);
    }
}

use std::env;
use std::path::PathBuf;
use std::process::Command;

fn show_usage() -> ! {
    eprintln!("Usage:");
    eprintln!("  screencap screenshot <all|area|active> [-o <path>]");
    eprintln!("  screencap ocr <area|active>");
    eprintln!("Options:");
    eprintln!("  -o <path>    Output file path (screenshot mode only)");
    eprintln!("  -h, --help   Show this message");
    std::process::exit(1);
}

#[derive(Debug)]
enum Target {
    All,
    Area,
    Active,
}

impl Target {
    fn as_grimblast_target(&self) -> &'static str {
        match self {
            Target::All => "screen",
            Target::Area => "area",
            Target::Active => "active",
        }
    }

    fn parse(s: &str) -> Option<Self> {
        match s {
            "all" => Some(Target::All),
            "area" => Some(Target::Area),
            "active" => Some(Target::Active),
            _ => None,
        }
    }
}

fn now_timestamp() -> String {
    let secs = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs();
    format!("{secs}")
}

fn pictures_dir() -> PathBuf {
    let home = env::var("HOME").unwrap_or_else(|_| "/tmp".into());
    PathBuf::from(home).join("Pictures").join("screenshots")
}

fn notify(summary: &str, body: &str, critical: bool) {
    let mut cmd = Command::new("notify-send");
    if critical {
        cmd.arg("-u").arg("critical");
    }
    cmd.arg("-a").arg("screencap");
    // Ignore errors — notification is best-effort
    let _ = cmd.arg(summary).arg(body).status();
}

fn json_error(message: &str) -> ! {
    // Escape double quotes and backslashes
    let escaped = message.replace('\\', "\\\\").replace('\"', "\\\"");
    println!("{{\"type\":\"error\",\"message\":\"{}\"}}", escaped);
    std::process::exit(1);
}

fn json_screenshot(path: &str) {
    let escaped = path.replace('\\', "\\\\").replace('\"', "\\\"");
    println!("{{\"type\":\"screenshot\",\"status\":\"ok\",\"path\":\"{}\"}}", escaped);
}

fn json_ocr(text: &str) {
    let escaped = text
        .replace('\\', "\\\\")
        .replace('\"', "\\\"")
        .replace('\n', "\\n")
        .replace('\t', "\\t")
        .replace('\r', "");
    println!("{{\"type\":\"ocr\",\"status\":\"ok\",\"text\":\"{}\"}}", escaped);
}

fn find_grimblast() -> Command {
    Command::new("grimblast")
}

fn do_screenshot(target: Target, output_path: &str) -> Result<String, String> {
    // Ensure output directory exists
    if let Some(parent) = PathBuf::from(output_path).parent() {
        std::fs::create_dir_all(parent)
            .map_err(|e| format!("Failed to create output directory: {e}"))?;
    }

    let grimblast_target = target.as_grimblast_target();
    let status = find_grimblast()
        .arg("save")
        .arg(grimblast_target)
        .arg(output_path)
        .status()
        .map_err(|e| format!("Failed to run grimblast: {e}"))?;

    if !status.success() {
        return Err(format!("grimblast failed with exit code {:?}", status.code()));
    }

    // Copy to clipboard
    let clip_status = Command::new("wl-copy")
        .args(["-t", "image/png"])
        .stdin(std::fs::File::open(output_path).map_err(|e| format!("Failed to open for clipboard: {e}"))?)
        .status()
        .map_err(|e| format!("Failed to run wl-copy: {e}"))?;

    if !clip_status.success() {
        // Clipboard failure is not fatal for screenshot
        eprintln!("Warning: wl-copy failed");
    }

    Ok(output_path.to_string())
}

fn do_ocr(target: Target) -> Result<String, String> {
    let tmp_path = format!(
        "/tmp/screencap-ocr-{}.png",
        std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .unwrap_or_default()
            .as_nanos()
    );

    // Capture to temp file
    let grimblast_target = target.as_grimblast_target();
    let status = find_grimblast()
        .arg("save")
        .arg(grimblast_target)
        .arg(&tmp_path)
        .status()
        .map_err(|e| format!("Failed to run grimblast: {e}"))?;

    if !status.success() {
        let _ = std::fs::remove_file(&tmp_path);
        return Err(format!("grimblast failed with exit code {:?}", status.code()));
    }

    // Run OCR — use defaults first, which works on all tesseract installations
    let output = Command::new("tesseract")
        .arg(&tmp_path)
        .arg("stdout")
        .output()
        .map_err(|e| format!("Failed to run tesseract: {e}"))?;

    // Clean up temp file
    let _ = std::fs::remove_file(&tmp_path);

    if !output.status.success() {
        return Err("tesseract OCR failed".to_string());
    }

    let text = String::from_utf8_lossy(&output.stdout)
        .trim()
        .to_string();

    if text.is_empty() {
        return Err("No text found in image".to_string());
    }

    // Copy to clipboard
    let mut wl_copy = Command::new("wl-copy")
        .stdin(std::process::Stdio::piped())
        .spawn()
        .map_err(|e| format!("Failed to spawn wl-copy: {e}"))?;

    use std::io::Write;
    if let Some(mut stdin) = wl_copy.stdin.take() {
        let _ = stdin.write_all(text.as_bytes());
    }

    let clip_status = wl_copy
        .wait()
        .map_err(|e| format!("wl-copy failed: {e}"))?;

    if !clip_status.success() {
        eprintln!("Warning: wl-copy failed");
    }

    Ok(text)
}

fn run() -> Result<(), String> {
    let mut args = env::args().skip(1);
    let command = args.next().unwrap_or_else(|| show_usage());

    match command.as_str() {
        "screenshot" => {
            let mut target: Option<Target> = None;
            let mut output_path: Option<String> = None;

            while let Some(arg) = args.next() {
                match arg.as_str() {
                    "-o" => {
                        output_path = Some(args.next().ok_or("-o requires a path argument")?);
                    }
                    "-h" | "--help" => show_usage(),
                    s if s.starts_with('-') => {
                        return Err(format!("Unknown flag: {s}"));
                    }
                    _ => {
                        target = Target::parse(&arg);
                        if target.is_none() {
                            return Err(format!(
                                "Unknown target: {arg}. Expected all, area, or active"
                            ));
                        }
                    }
                }
            }

            let target = target.unwrap_or_else(|| show_usage());
            let output = output_path.unwrap_or_else(|| {
                std::fs::create_dir_all(pictures_dir()).ok();
                pictures_dir()
                    .join(format!("screenshot-{}.png", now_timestamp()))
                    .to_string_lossy()
                    .to_string()
            });

            let path = do_screenshot(target, &output)?;
            json_screenshot(&path);
            notify("Screenshot saved", &path, false);
        }

        "ocr" => {
            let target = args
                .next()
                .and_then(|s| Target::parse(&s))
                .unwrap_or_else(|| show_usage());

            let text = do_ocr(target)?;
            json_ocr(&text);
            notify("OCR result", &text, false);
        }

        "-h" | "--help" => show_usage(),
        other => {
            eprintln!("Unknown command: {other}");
            show_usage();
        }
    }

    Ok(())
}

fn main() {
    if let Err(e) = run() {
        json_error(&e);
    }
}

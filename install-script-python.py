import subprocess
import sys
from pathlib import Path

INSTALL_CMD = "yay -S --needed --noconfirm"

# TODO: install quickshell from source
CORE_PACKAGES = [
    "swww", "neovim", "kitty", "wallust", "fish", "fastfetch",
    # Utilities?
    "grimblast", "hyprpicker"
]

OTHER_PACKAGES = [
    "man-db",
    "7zip", "fd", "ripgrep", "tree",
    "ncdu", "btop",
    "blueman",
    "copyq", "nwg-look",
    "vesktop", "zen-browser-bin", "speedcrunch"
]

OPTIONAL_PACKAGES = {
    "keepassxc":             "Install KeepassXC?",
    "spotify-launcher":      "Install Spotify?",
    "steam-native-runtime":  "Install Steam?",
    "prismlauncher":         "Install PrismLauncher (Minecraft)?",
    "heroic-games-launcher": "Install HeroicGames Launcher (GOG + Epic Games)?",
    "qbittorrent":           "Install QBittorrent?"
}


def announce(msg: str):
    print('=' * 40)
    print(msg.center(40, ' '))
    print('=' * 40)


def run(cmd, cwd=None):
    """Run a shell command and exit on failure."""
    try:
        subprocess.run(cmd, shell=True, check=True, cwd=cwd)
    except subprocess.CalledProcessError as e:
        print(f"Command failed: {e.cmd}", file=sys.stderr)
        sys.exit(1)


def is_installed(pkg):
    """Return True if a pacman package is installed."""
    result = subprocess.run(
        f"pacman -Qi {pkg}",
        shell=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
    )
    return result.returncode == 0


def confirm(prompt: str):
    """Ask the user for yes/no confirmation."""
    while True:
        ans = input(f"{prompt} (y/n) ").strip().lower()
        if ans in ("y", "yes"):
            return True
        elif ans in ("n", "no"):
            return False
        else:
            print("Please answer y or n.")


def install_package(pkg: str):
    """Install a package if not installed."""
    if not is_installed(pkg):
        print(f"Installing {pkg}...")
        run(f"{INSTALL_CMD} {pkg}")


def install_packages(pkgs: list[str]):
    """Install a list of packages."""
    for pkg in pkgs:
        install_package(pkg)


def install_yay():
    """Install yay if missing."""
    if not is_installed("yay"):
        announce("Installing yay (Yet Another Yaourt)")

        run("sudo pacman -S --needed git base-devel")

        repo_dir = Path("yay")
        if repo_dir.exists():
            run("rm -rf yay")

        run("git clone https://aur.archlinux.org/yay.git")
        run("makepkg -si", cwd="yay")
        run("rm -rf yay")


def install_optional_packages(packages_dict: dict[str, str]):
    """Prompt for optional packages and install if confirmed."""
    for pkg, prompt_text in packages_dict.items():
        if not is_installed(pkg):
            if confirm(prompt_text):
                install_package(pkg)


def main():
    install_yay()

    announce("Installing core packages")
    install_packages(CORE_PACKAGES)

    if not is_installed("starship"):
        announce("Installing starship")
        install_package("starship")

    announce("Installing other wanted packages")
    install_packages(OTHER_PACKAGES)

    announce("Installing optional packages")
    install_optional_packages(OPTIONAL_PACKAGES)

    announce("Installation Complete!")


if __name__ == "__main__":
    main()

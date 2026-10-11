# Custom environment

My personal NixOS configuration and dotfiles for user `hhhh` on host `nixos`
(`x86_64-linux`). The desktop uses Hyprland, Kitty, Neovim, and Bash, with
Home Manager linking application settings directly to this repository.

## Toolset

| Tool | Purpose |
| --- | --- |
| [Hyprland](https://hypr.land/) | Wayland desktop compositor |
| Waybar / Wofi / Mako | Status bar, application launcher, and notifications |
| SDDM / Hyprlock | Login screen and session locking |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator |
| [Neovim](https://neovim.io/) | Editor and development environment |
| [Starship](https://starship.rs/) | Fast, minimal shell prompt |
| [direnv](https://direnv.net/) | Per-project environment variables |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter directory navigation |
| [Atuin](https://atuin.sh/) | Searchable shell history |
| ble.sh | Interactive Bash editing and completion |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finding from the command line |
| [eza](https://github.com/eza-community/eza) | Modern replacement for `ls` |
| [GitUI](https://github.com/gitui-org/gitui) | Terminal UI for Git |

The shell configuration also includes shortcuts for Meson and Ninja builds,
sanitizer-assisted test runs, `perf`, FlameGraph, and systemd user scopes.

## Repository layout

```text
.
├── flake.nix             # Reproducible NixOS entry point
├── flake.lock            # Pinned dependency revisions
├── nixos/                # Host and reusable NixOS modules
├── bash/                 # Bash environment, aliases, and helper functions
├── atuin/                # Atuin configuration
├── git/                  # Git settings and aliases
├── gitui/                # GitUI key bindings
├── kitty/                # Kitty settings and color themes
├── hypr/                 # Hyprland Lua config, monitors, wallpapers, and locking
├── sddm/                 # Custom Qt 6 login theme
├── mako/                 # Notification settings
├── nvim/                 # Neovim Lua configuration, plugins, LSP, and themes
├── waybar/               # Compact Hyprland status bar and power menu
├── wofi/                 # Application launcher with icons
└── wallpapers/           # Desktop wallpapers
```

Starship, direnv, zoxide, fzf, and eza do not currently have dedicated
configuration directories tracked in this repository.

## NixOS

The flake exposes the `nixos` host. Its machine-specific configuration lives
in `nixos/hosts/nixos`, while reusable settings are grouped by purpose in
`nixos/modules`. Packages are split into desktop, development, shell, and
general utility modules under `nixos/modules/packages`. The main Nixpkgs input
uses `nixos-26.05`; Home Manager uses `release-26.05` and follows that input.
The configuration enables NVIDIA graphics, PipeWire audio, NetworkManager,
OpenSSH, Podman, and Throne with TUN support.

From the repository root, check and apply the configuration with:

```bash
nix flake check --no-build
sudo nixos-rebuild switch --flake .#nixos
```

Use `nix flake check` for a full check including builds; `--no-build` checks
configuration evaluation without building the checks.

On the first run, if flakes are not enabled in the currently booted system,
pass the feature flags explicitly:

```bash
sudo nixos-rebuild switch \
  --extra-experimental-features 'nix-command flakes' \
  --flake .#nixos
```

Update all pinned flake inputs and rebuild with:

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

Codex is taken from a separately pinned Nixpkgs `master` input so it can be
updated without upgrading the stable NixOS package set:

```bash
nix flake update codex-nixpkgs
sudo nixos-rebuild switch --flake .#nixos
```

The `codex-background-server` user service starts automatically when `hhhh`
logs in and listens on the local Unix socket. Connect with
`codex --remote unix://`. Check its status with
`systemctl --user status codex-background-server` and view its logs with
`journalctl --user -u codex-background-server`.

Before applying this configuration on another machine, replace
`nixos/hosts/nixos/hardware-configuration.nix` with that machine's configuration
and review the host name, user, graphics driver, and monitor settings.
`nixos/hosts/nixos/default.nix` also copies Windows EFI files from a specific
partition to `/boot/EFI/` during bootloader installation; adapt or remove that
hook if the target machine does not use this dual-boot layout.

Keep `system.stateVersion` and `home.stateVersion` at their initial setup
versions when updating packages. Ordinary package additions do not require
updating `flake.lock`.

## Hyprland desktop

The active configuration is `hypr/hyprland.lua`, which loads `monitors.lua`.
The neighboring `monitors.conf` and `workspaces.conf` are not loaded by it.
Workspaces 1–10 belong to `DP-3`; `HDMI-A-2` has a dedicated named workspace.
Monitor modes and positions live in `monitors.lua`, and wallpaper assignments
live in `hypr/hyprpaper.conf`.

Hyprland starts Hyprpaper, Waybar, and the Home Manager `udiskie` service.
Udiskie automatically mounts removable media without a tray icon.

| Shortcut | Action |
| --- | --- |
| `Super+T` | Open Kitty |
| `Super+R` | Open Wofi |
| `Super+C` | Close the active window |
| `Super+L` | Lock the session |
| `Super+Shift+S` | Copy a region screenshot to the clipboard |
| `Super+1` … `Super+0` | Select workspace 1–10 |
| `Super+Shift+1` … `Super+Shift+0` | Move a window to workspace 1–10 |
| `Alt+H` / `Alt+L` | Cycle primary-monitor workspaces |
| `Ctrl+Space` | Switch English/Russian keyboard layouts |

Waybar settings are in `waybar/config.jsonc` and `waybar/style.css`;
`waybar/power-menu.sh` provides lock, suspend, reboot, and power-off actions.

## Screen locking

The initial SDDM login screen uses a matching Qt 6 theme in `sddm/`, packaged
by `nixos/modules/login-theme.nix`. Its assets and ProFont are included in
the theme package so they are available before a user session starts.
It supports username/password entry, desktop session selection, and power
actions. Apply with `nixos-rebuild switch`; the theme appears at the next
login. Avoid restarting the display manager during an active session.

Hyprlock uses `hypr/hyprlock.conf` and the existing wallpaper assets for a
blurred, two-column lock screen with ProFont, a clock, and live system status.
Press `Super+L` or choose **Lock** in the Waybar power menu.
`hypr/hypridle.conf` defines session locking and a lock request before suspend,
with no idle timeout. Hypridle is not currently installed or started by the
tracked configuration; these hooks require installing and running it.
The NixOS Hyprlock module supplies its PAM authentication configuration.

## Home Manager

Home Manager is integrated into the NixOS flake and uses the same pinned
Nixpkgs input. The user configuration lives in `nixos/home/hhhh.nix`.
It manages `atuin`, `gitui`, `hypr`, `kitty`, `mako`, `nvim`, `waybar`, and
`wofi` under `~/.config`.

These directories link to `~/Git/Custom-environment` through
`mkOutOfStoreSymlink`, so edits in the repository are available immediately.
Reload or restart the affected application to pick up configuration changes.
Keep the repository at this location, or adjust `repo` in the user module.

Apply Home Manager changes together with the system configuration:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

On activation, conflicting configuration files or links are backed up with
the `.hm-backup` suffix; links already pointing to the same content can be
adopted without a backup. Existing backups are preserved; move an old
backup aside if it blocks activation. Keep `home.stateVersion` at the version
used when first enabling Home Manager.

## Installation

On NixOS, clone the repository into the location expected by Home Manager,
review the machine-specific settings described above, then check and apply
the flake:

```bash
git clone git@github.com:Claucdan/Custom-environment.git ~/Git/Custom-environment
cd ~/Git/Custom-environment
nix flake check --no-build
sudo nixos-rebuild switch --flake .#nixos
```

On other distributions, install the tools using your system package manager
and link the configuration directories manually. Inspect existing settings
and move conflicting files or directories aside before creating links:

```bash
git clone git@github.com:Claucdan/Custom-environment.git ~/Git/Custom-environment
cd ~/Git/Custom-environment
mkdir -p "$HOME/.config"

for config in atuin gitui hypr kitty mako nvim waybar wofi; do
    ln -s "$PWD/$config" "$HOME/.config/$config"
done
```

## Bash and Git

Home Manager does not manage `bash/` or `git/`. Review their settings and back
up any existing `~/.bashrc` and `~/.gitconfig` before linking them separately:

```bash
cd ~/Git/Custom-environment
ln -s "$PWD/bash/.bashrc" "$HOME/.bashrc"
ln -s "$PWD/git/.gitconfig" "$HOME/.gitconfig"
```

Link the Bash entry point rather than copying it: it resolves the `~/.bashrc`
symlink to locate `env.bash`, `aliases.bash`, `build.bash`, `perf.bash`,
`systemd.bash`, and `tools.bash`. Machine-specific additions belong in
`bash/local.*.bash`, which is ignored by Git. Start a new interactive Bash
session after changing the links.

The Git configuration includes `~/Git/Custom-environment/git/aliases.gitconfig`,
uses Neovim as its editor, and enables pull rebase with automatic stashing.
Adjust the include path if you keep the repository elsewhere.

## Notes

- NixOS installs ProFont Nerd Font, Font Awesome, and Noto fonts. Kitty uses
  `ProFontWindows Nerd Font Mono`; install it separately on other distributions.
- Neovim plugins are managed with
  [lazy.nvim](https://github.com/folke/lazy.nvim); open Neovim after linking the
  configuration to install them. The entry point is `nvim/init.lua`, plugin
  specifications are in `nvim/lua/plugins/`, and settings are in
  `nvim/lua/configs/`. `nvim/lazy-lock.json` is currently ignored by Git, so
  plugin versions are not pinned by this repository.
- This is a personal setup rather than a universal bootstrap script. Feel free
  to copy or adapt any part of it.

# Custom environment

My personal development environment and dotfiles. The repository contains the
configuration I use to keep the terminal, editor, shell history, and Git
workflow consistent across machines.

## Toolset

| Tool | Purpose |
| --- | --- |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal emulator |
| [Neovim](https://neovim.io/) | Editor and development environment |
| [Starship](https://starship.rs/) | Fast, minimal shell prompt |
| [direnv](https://direnv.net/) | Per-project environment variables |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter directory navigation |
| [Atuin](https://atuin.sh/) | Searchable shell history |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finding from the command line |
| [eza](https://github.com/eza-community/eza) | Modern replacement for `ls` |
| [GitUI](https://github.com/gitui-org/gitui) | Terminal UI for Git |

The shell configuration also includes shortcuts for Meson and Ninja builds,
sanitizer-assisted test runs, `perf`, FlameGraph, and systemd user scopes.

## Repository layout

```text
.
├── flake.nix             # Reproducible NixOS entry point
├── nixos/                # Host and reusable NixOS modules
├── bash/                 # Bash environment, aliases, and helper functions
├── atuin/                # Atuin configuration
├── gitui/                # GitUI key bindings
├── kitty/                # Kitty settings and color themes
├── nvim/                 # Neovim configuration and plugin lockfile
└── wallpapers/           # Desktop wallpapers
```

Starship, direnv, zoxide, fzf, and eza do not currently have dedicated
configuration directories tracked in this repository.

## NixOS

The flake exposes the `nixos` host. Its machine-specific configuration lives
in `nixos/hosts/nixos`, while reusable settings are grouped by purpose in
`nixos/modules`. Packages are split into desktop, development, shell, and
general utility modules under `nixos/modules/packages`.

From the repository root, check and apply the configuration with:

```bash
nix flake check
sudo nixos-rebuild switch --flake .#nixos
```

On the first run, if flakes are not enabled in the currently booted system,
pass the feature flags explicitly:

```bash
sudo nixos-rebuild switch \
  --extra-experimental-features 'nix-command flakes' \
  --flake .#nixos
```

Update the pinned Nixpkgs revision and rebuild with:

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

Before using this configuration on another machine, regenerate or replace
`nixos/hosts/nixos/hardware-configuration.nix` and adjust the host name,
user, graphics driver, and `system.stateVersion` as appropriate.

## Installation

Clone the repository, install the tools listed above using your system package
manager, and link the configuration files into their expected locations. For
example:

```bash
git clone git@github.com:Claucdan/Custom-environment.git
cd Custom-environment

ln -sfn "$PWD/nvim" "$HOME/.config/nvim"
ln -sfn "$PWD/kitty" "$HOME/.config/kitty"
ln -sfn "$PWD/atuin" "$HOME/.config/atuin"
ln -sfn "$PWD/gitui" "$HOME/.config/gitui"
```

Review `.bashrc` before sourcing or linking it: some aliases, paths, and helper
functions are tailored to my local development setup.

## Notes

- A [Nerd Font](https://www.nerdfonts.com/) is recommended for Kitty,
  Starship, and terminal icons.
- Neovim plugins are managed with
  [lazy.nvim](https://github.com/folke/lazy.nvim); open Neovim after linking the
  configuration to install them.
- This is a personal setup rather than a universal bootstrap script. Feel free
  to copy or adapt any part of it.

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
├── .bashrc               # Bash environment, aliases, and helper functions
├── atuin/                # Atuin configuration
├── gitui/                # GitUI key bindings
├── kitty/                # Kitty settings and color themes
├── nvim/                 # Neovim configuration and plugin lockfile
└── wallpapers/           # Desktop wallpapers
```

Starship, direnv, zoxide, fzf, and eza do not currently have dedicated
configuration directories tracked in this repository.

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

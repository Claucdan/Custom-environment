# ~/.bashrc

# Interactive shell only.
[[ $- != *i* ]] && return

# Resolve ~/.bashrc -> actual dotfiles/bash/.bashrc
BASH_CONFIG_DIR="$(
    dirname -- "$(readlink -f "$HOME/.bashrc")"
)"

# Regular configuration.
for file in \
    env.bash \
    aliases.bash \
    build.bash \
    perf.bash \
    systemd.bash \
    tools.bash
do
    [[ -r "$BASH_CONFIG_DIR/$file" ]] && source "$BASH_CONFIG_DIR/$file"
done

# Local configuration.
for file in "$BASH_CONFIG_DIR"/local.*.bash; do
    [[ -r "$file" ]] && source "$file"
done

unset file

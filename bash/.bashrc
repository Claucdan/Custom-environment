# ~/.bashrc

[[ $- != *i* ]] && return

BASH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bash"

for config in \
    env \
    aliases \
    build \
    perf \
    systemd \
    tools
do
    file="$BASH_CONFIG_DIR/$config.bash"
    [[ -r "$file" ]] && source "$file"
done

# Machine/private configuration.
[[ -r "$BASH_CONFIG_DIR/local.bash" ]] &&
    source "$BASH_CONFIG_DIR/local.bash"

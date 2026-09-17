# bash-completion
if ! shopt -oq posix; then
    if [[ -r /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -r /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
fi

# ble.sh
[[ -r "$HOME/.local/share/blesh/out/ble.sh" ]] &&
    source "$HOME/.local/share/blesh/out/ble.sh"

# NVM
export NVM_DIR="$HOME/.nvm"

[[ -s "$NVM_DIR/nvm.sh" ]] &&
    source "$NVM_DIR/nvm.sh"

[[ -s "$NVM_DIR/bash_completion" ]] &&
    source "$NVM_DIR/bash_completion"

# Shell integrations
command -v starship &>/dev/null &&
    eval "$(starship init bash)"

command -v zoxide &>/dev/null &&
    eval "$(zoxide init bash)"

command -v atuin &>/dev/null &&
    eval "$(atuin init bash)"

command -v direnv &>/dev/null &&
    eval "$(direnv hook bash)"

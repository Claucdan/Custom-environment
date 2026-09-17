export TERM=xterm-256color

path_prepend() {
    [[ -d "$1" ]] || return
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

path_append() {
    [[ -d "$1" ]] || return
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$PATH:$1" ;;
    esac
}

path_prepend "$HOME/.local/bin"
path_prepend "${GOBIN:-${GOPATH:-$HOME/go}/bin}"
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.ghcup/bin"
path_prepend "$HOME/gitui"
path_append "$HOME/Git/FlameGraph"
path_append "$HOME/.fzf/bin"

export PATH

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

shopt -s histappend
shopt -s checkwinsize

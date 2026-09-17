_builddir_for() {
    case "$1" in
        debug)
            printf '%s\n' "${BUILDDIR_DEBUG:-builddir-debug}"
            ;;
        release)
            printf '%s\n' "${BUILDDIR_RELEASE:-builddir-release}"
            ;;
        *)
            echo "Unknown build type: $1" >&2
            return 2
            ;;
    esac
}

_ensure_builddir() {
    local type="$1"
    local dir
    local native_args=()

    dir="$(_builddir_for "$type")" || return

    if [[ -f native.ini ]]; then
        native_args+=(--native-file native.ini)
    fi

    if [[ ! -f "$dir/meson-private/coredata.dat" ]]; then
        echo "Configuring Meson $type build in '$dir'..." >&2

        meson setup "$dir" \
            --buildtype="$type" \
            "${native_args[@]}" >&2 || return
    fi

    printf '%s\n' "$dir"
}

_nic() {
    local type="$1"
    shift

    local dir
    dir="$(_ensure_builddir "$type")" || return

    ninja -C "$dir" "$@"
}

nic() {
    _nic "${BUILD_TYPE:-debug}" "$@"
}

nic-debug() {
    _nic debug "$@"
}

nic-release() {
    _nic release "$@"
}

nit() {
    if (($# == 0)); then
        echo "usage: nit <target> [args...]" >&2
        return 2
    fi

    local target="$1"
    local type="${BUILD_TYPE:-debug}"
    local dir

    shift

    dir="$(_ensure_builddir "$type")" || return

    ninja -C "$dir" "$target" || return
    "$dir/$target" "$@"
}

nicc() {
    if (($# == 0)); then
        echo "usage: nicc <target> [ninja args...]" >&2
        return 2
    fi

    local target="$1"
    local type="${BUILD_TYPE:-debug}"
    local dir
    local filename

    shift

    dir="$(_ensure_builddir "$type")" || return
    filename="${target##*/}"

    ninja -C "$dir" "$target" "$@" || return

    install -Dm755 \
        "$dir/$target" \
        "$HOME/.local/bin/$filename" || return

    "$filename" --version
}

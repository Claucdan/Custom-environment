set-scope() {
    local scope="${1:-default-scope}"

    systemd-run \
        --user \
        --scope \
        --unit="$scope" \
        bash
}

check-scope() {
    local scope="${1:-default-scope}"

    systemctl --user status "$scope.scope"
}

shtop() {
    local scope="${1:-default-scope.scope}"
    local cg

    cg=$(systemctl --user show \
        "$scope" \
        -p ControlGroup \
        --value) || return

    htop -p "$(paste -sd, "/sys/fs/cgroup${cg}/cgroup.procs")"
}

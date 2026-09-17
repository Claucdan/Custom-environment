alias perf-rec='perf record -g -e cpu-cycles -p'
alias perf-rep='perf report'

perf-dat() {
    perf script | stackcollapse-perf.pl > "$1"
}

flamegraph() {
    local perf_name="${1:-pdat}"

    [[ -f perf.data ]] || {
        echo "perf.data not found" >&2
        return 1
    }

    mkdir -p img

    perf-dat "$perf_name" &&
        flamegraph.pl "$perf_name" > "img/$perf_name.svg"
}

flamegraph-diff() {
    if [[ -f "$1" && -f "$2" ]]; then
        mkdir -p img
        difffolded.pl "$1" "$2" |
            flamegraph.pl > "img/perf-diff-$1-$2.svg"
    fi
}

binlog-dump() {
    barsic dump \
        --prefix="$1" \
        --no-start-echo \
        -- binlog-dumper --module "$2"
}

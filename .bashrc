# some more ls aliases
export TERM=xterm-256color
export PATH="$HOME/gitui:$PATH"
export PATH="${GOBIN:-${GOPATH:-${HOME}/go}/bin}:${PATH}"
alias lsf="ls -p | grep -v /"

# Shortcuts for build/test
alias mss="meson setup builddir-debug --native-file=native.ini --buildtype=debug"
alias mss-release="meson setup builddir-release --native-file=native.ini --buildtype=release"

alias msr="meson setup builddir-debug --native-file=native.ini --buildtype=debug --reconfigure"
alias msr-release="meson setup builddir-release --native-file=native.ini --buildtype=release --reconfigure"

alias msc="meson compile -C builddir-debug"
alias msc-release="meson compile -C builddir-release"

alias mst="meson test -C builddir-debug"
alias mst-release="meson test -C builddir-release"

alias msb="meson test -C builddir-release --benchmark"
mstf() {
  mst -v $1 --test-arg=\"--gtest_filter=\"*$2*\"\"
}

# Ninja
alias nic="ninja -C builddir-debug"
alias nic-release="ninja -C builddir-release"
alias ninja_test_env="env MALLOC_PERTURB_=8 UBSAN_OPTIONS='halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1' MSAN_OPTIONS='halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1' ASAN_OPTIONS='halt_on_error=1:abort_on_error=1:print_summary=1' MESON_TEST_ITERATION=1 "
nit() {
  nic $1 && ninja_test_env $(pwd)/builddir-debug/$1
}
nitf() {
  nic $1 && ninja_test_env $(pwd)/builddir-debug/$1 --gtest_filter=$2
}

nicc() {
  filepath=$1
  filename="${filepath##*/}"
  nic $1 && cp ./builddir-debug/$1 ~/.local/bin/ && $filename --version
}


# For fast build
export CCACHE_DIR=$HOME/.engine_ccache
export CCACHE_UMASK=007
export CCACHE_LOGFILE=$HOME/.engine_ccache/.log
export CCACHE_NLEVELS=4
export KDB_USE_CCACHE=1

# For tests
export MESON_BUILD=true
export MESON_BUILD_DIR="builddir-debug"
export PATH="$HOME/engine/tornado/bin:$PATH"
export TORNADO_VKGO_PATH="$HOME/Git/vkgo"
export TORNADO_MAKE_DISABLED=1

# For debugging
export PATH="$HOME/Git/FlameGraph/:$PATH"
alias perf-rec="perf record -g -e cpu-cycles -p"
alias perf-rep="perf report"
alias perf-dat="perf script | stackcollapse-perf.pl >"

flamegraph() {
  PERF_NAME="pdat"
  if [ "$#" -ne 0 ]; then
    PERF_NAME=$1
  fi
  if [ -f perf.data ]; then
    mkdir -p img
    perf-dat $PERF_NAME
    flamegraph.pl $PERF_NAME > img/$PERF_NAME.svg
  fi
}

flamegraph-diff() {
  if [ -f $1 ] && [ -f $2 ]; then
    difffolded.pl $1 $2 | flamegraph.pl > img/perf-diff-$1-$2.svg
  fi
}

binlog-dump() {
  barsic dump --prefix=$1 --no-start-echo -- binlog-dumper --module $2 
}


set-scope() {
  SCOPE="default-scope"
  if [ "$#" -ne 0 ]; then
    SCOPE=$1
  fi
  systemd-run --user --scope --unit=$SCOPE bash
}

check-scope() {
  SCOPE="default-scope"
  if [ "$#" -ne 0 ]; then
    SCOPE=$1
  fi
  systemctl --user status $SCOPE.scope
}

shtop() {
  local SCOPE="default-scope.scope"

  if [ "$#" -ne 0 ]; then
    SCOPE="$1"
  fi

  local CG
  CG=$(systemctl --user show "$SCOPE" -p ControlGroup --value) || return 1

  htop -p "$(paste -sd, "/sys/fs/cgroup${CG}/cgroup.procs")"
}


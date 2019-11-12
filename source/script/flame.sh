#!/bin/bash

perf_pid=

flame_graph_path=../FlameGraph/
user=$(whoami)

perf_file="$(hostnamectl --static)-${perf_pid}-$(date +%Y-%m-%d-%H-%M-%S)"

sudo perf record -F 99 -a -g -o "$perf_file".data -- sleep 60
sudo chown $user:$user "$perf_file".data
perf script -i "$perf_file".data > "$perf_file".perf
${flame_graph_path}/stackcollapse-perf.pl "$perf_file".perf > "$perf_file".folded
${flame_graph_path}/flamegraph.pl "$perf_file".folded > "$perf_file".svg


if [ -e "$perf_file".svg ]; then
    rm "$perf_file".perf "$perf_file".folded
fi

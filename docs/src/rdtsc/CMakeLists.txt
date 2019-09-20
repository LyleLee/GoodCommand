project(rdtsc)
cmake_minimum_required(VERSION 2.8)

add_executable(be.out benchmark_cycle.c)
add_executable(ce.out ceph_cycle.c)

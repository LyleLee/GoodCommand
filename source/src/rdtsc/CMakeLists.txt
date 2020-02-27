project(rdtsc)
cmake_minimum_required(VERSION 2.8)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99 -g -Wall")
add_executable(google_benchmark_cycle.out google_benchmark_cycle.c)
add_executable(ceph_cycle.out ceph_cycle.c)
add_executable(clock_gettime.out clock_gettime.c)

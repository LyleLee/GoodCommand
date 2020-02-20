cmake_minimum_required(VERSION 2.8)
project(virtual_net)

set(CMAKE_VERBOSE_MAKEFILE off)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -fsanitize=address")

aux_source_directory(. SRC)
add_executable(create_tun.out create_tun.c)

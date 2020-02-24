cmake_minimum_required(VERSION 2.8)
project(tap_virtual_net)

set(CMAKE_VERBOSE_MAKEFILE off)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -fsanitize=address")

aux_source_directory(. SRC)
add_executable(create_tap.out create_tap.c)

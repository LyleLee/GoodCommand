project(leetcode)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -fsanitize=address")
link_directories(/usr/lib64)
link_directories(/opt/rh/devtoolset-7/root/usr/lib/gcc/aarch64-redhat-linux/7)

aux_source_directory(. SRC)
add_executable(median.out median-of-two-sorted-arrays.c)
add_executable(reverse.out 25-reverse-nodes-in-k-group.c)
add_executable(3.out 3-longest-substring-without-repeating-characters.c)
add_executable(5.out 5-longest-palindromic-substring.c)
add_executable(151.out 151-reverse-words-in-a-string.c)
add_executable(224.out 224.c)
cmake_minimum_required(VERSION 2.80)

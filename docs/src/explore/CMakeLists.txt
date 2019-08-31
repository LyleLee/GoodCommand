cmake_minimum_required (VERSION 2.8)

project (explore)


# 查找当前目录下的所有源文件
# 保存到变量

aux_source_directory(. DIR_SRCS)

add_executable(offsetof offsetof.c)
add_executable(clib_offsetof clib_offsetof.c)
add_executable(container_of container_of.c)
add_executable(container_of_2 container_of_2.c)

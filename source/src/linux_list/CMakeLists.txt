cmake_minimum_required (VERSION 2.8)

project (linux_list)


# 查找当前目录下的所有源文件
# 保存到变量

aux_source_directory(. DIR_SRCS)

add_executable(linux_list ${DIR_SRCS})


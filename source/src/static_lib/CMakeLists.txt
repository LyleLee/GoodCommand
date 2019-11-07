cmake_minimum_required(VERSION 2.28)
project(_mylib)

aux_source_directory(. DIR_LIB_SRCS)

add_executable(driver.out ${DIR_LIB_SRCS})
add_library(_mylib ${DIR_LIB_SRCS})


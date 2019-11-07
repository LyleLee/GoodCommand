cmake_minimum_required(VERSION 3.10)
project(function_variable)
message("父目录 CMakeLists.txt文件")
set(MY_VAL "666")

message("第一次在父目录 MY_VAL=${MY_VAL}")

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake_modules)
include(Findtest)

test(${MY_VAL})
message("中间变量 MY_VAL = ${MY_VAL}")
xyz(${MY_VAL})

message("第二次在父目录，MY_VAL=${MY_VAL}")
message("include test=${test_VAL}")

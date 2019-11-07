cmake_minimum_required(VERSION 3.0)
project("normal_variable")
message("父目录 CMakeLists.txt 文件")
set(MY_VAL "666")

message("第一次在父目录 MY_VAL =${MY_VAL}")
add_subdirectory(src)
message("第二次在父目录 MY_VAL=${MY_VAL}")


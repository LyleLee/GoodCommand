cmake_minimum_required(VERSION 3.10)
project(function_variable)
message("父目录 CMakeLists.txt文件")
set(MY_VAL "666")

message("第一次在父目录 MY_VAL=${MY_VAL}")

function(xyz test_VAL)
	message("argument test_VAL = ${test_VAL}")
	message("MY_VAL=${MY_VAL}")
	set (MY_VAL "888" PARENT_SCOPE)
	message("function is MY_VAL=${MY_VAL}")
endfunction(xyz)

xyz(${MY_VAL})
message("第二次在父目录，MY_VAL=${MY_VAL}")

cmake_minimum_required (VERSION 3.0)
project(cmake_twice_demo)

option(SING "want to sing a song" ON)

if(SING)
	set(SONG_NAME ${SONG_NAME} "make world a better place")
endif(SING)

message("sing it or not: ${SING}")

aux_source_directory(. SOURCE_DIR)
add_executable(robot ${SOURCE_DIR})

project(rdtsc)
cmake_minimum_required(VERSION 2.8)

message(${CMAKE_SYSTEM_PROCESSOR})
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g")

if (CMAKE_SYSTEM_PROCESSOR MATCHES "(x86)|(X86)|(amd64)|(AMD64)")
	set (CPU_ARCHITECTURE "__x86_64__")
	set (__x86_64__ "__x86_64__")
elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "(arm64)|(ARM64)|(aarch64)")
	set (CPU_ARCHITECTURE "__aarch64__")
	set (__aarch64__ "__aarch64__")
endif ()

set(CPU_AARCHITECTURE "__${CMAKE_SYSTEM_PROCESSOR}__")

configure_file("config.h.in" "config.h")


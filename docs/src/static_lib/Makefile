all: driver

driver:driver.o lib_mylib.a
	cc -c driver.c -o driver.o
	cc -o driver driver.o -L. -l_mylib

lib_mylib.a:lib_mylib.c lib_mylib.h
	#compile but not link
	cc -c lib_mylib.c -o lib_mylib.o
	#generate lib from many object file
	ar rcs lib_mylib.a lib_mylib.o

clean:
	rm *.o *.a driver

.PHONY:clean

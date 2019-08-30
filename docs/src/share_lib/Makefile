all: app

app: liblowcase.so application.c
	gcc application.c -L. -llowcase -o app

liblowcase.so: lowcase.c
	gcc -shared -fPIC -o liblowcase.so lowcase.c

clean:
	rm *.o *.so app

.PHONY:clean

all:
	gcc sha1.c -static -I /home/banana/sslinstall/include -L /home/banana/sslinstall/lib -lcrypto -o sha1.out
	gcc sha256.c -static -I /home/banana/sslinstall/include -L /home/banana/sslinstall/lib -lcrypto -o sha256.out

	gcc sha1.c -march=armv8-a -static  -I /home/banana/sslinstall/include -L /home/banana/sslinstall/lib -lssl -lcrypto -o sha1.armv8.out
	gcc sha256.c -march=armv8-a -static -I /home/banana/sslinstall/include -L /home/banana/sslinstall/lib -lssl -lcrypto -o sha256.armv8.out

# there is a recommendation that -lssl should be added. but the above -lcrypto seems to work fine.

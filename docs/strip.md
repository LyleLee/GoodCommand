strip 
=====================
Discard symbols from object files. 删除目标文件得符号信息


编译目标文件
```shell-console
[me@centos stream]$ gcc -O2 -mcmodel=large -fopenmp -DSTREAM_ARRAY_SIZE=10000000 -DNTIMES=30 -DOFFSET=4096 stream.c -o stream
```
查看目标文件是 not striped的，大小74144 Byte
```
[me@centos stream]$ file stream
stream: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 3.7.0, BuildID[sha1]=cdb301912f8c7d837cefa0bccfd6f8962f8aeae7, not stripped
[me@centos stream]$ ls -la stream
-rwxrwxr-x. 1 me me 74144 Aug 21 10:26 stream
```
strip目标文件
```
[me@centos stream]$ strip stream
```
查看目标文件是striped，大小67744 Byte
```
[me@centos stream]$ file stream
stream: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 3.7.0, BuildID[sha1]=cdb301912f8c7d837cefa0bccfd6f8962f8aeae7, stripped
[me@centos stream]$ ls -la stream
-rwxrwxr-x. 1 me me 67744 Aug 21 10:26 stream
```

这是其中一个例子，像manggo DB之类编译后二进制文集那，可以由几百M变成几十M

strip之前
![](strip_binaru_file_size1.png)
strip之后
![](strip_binaru_file_size2.png)


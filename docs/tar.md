tar, zip
==========
压缩与解压缩

```CS
c - 创建一个压缩文件，如果只使用这个参数，不使用 z 参数，那么只会打包，不会压缩
x - 解开一个压缩文件
z - 是否使用 gzip 压缩或解压
j - 是否使用 bzip2 压缩或解压
v - 显示详细信息
f - 指定压缩后的文件名，后面要直接跟文件名，所以将 f 参数放到最后
```
```CS
#打包文档	Create an archive from files:
tar -cf {{target.tar}} {{file1 file2 file3}}

#打包、压缩文档	Create a gzipped archive:
tar -czf {{target.tar.gz}} {{file1 file2 file3}}

#解包文档	Extract an archive in a target directory:
tar -xf {{source.tar}} -C {{directory}}

#解包、解压缩文档	Extract a gzipped archive in the current directory:
tar -xzf {{source.tar.gz}}

#解包、解压缩文档	Extract a bzipped archive in the current directory:
tar -xjf {{source.tar.bz2}}

#根据后缀文件名选择压缩文件 Create a compressed archive, using archive suffix to determine the compression program:
tar -caf {{target.tar.xz}} {{file1 file2 file3}}

#List the contents of a tar file:
tar -tvf {{source.tar}}

#Extract files matching a pattern:
tar -xf {{source.tar}} --wildcards {{"*.html"}}
```

查看tar包的目录结构

depth=1 
```
tar --exclude="*/*" -tf file.tar
```
depth=2 
```
tar --exclude="*/*/*" -tf file.tar
```

解压命令
```
tar -zxvf xx.tar.gz
tar -jxvf xx.tar.bz2
```
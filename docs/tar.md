tar, zip
==========
压缩与解压缩



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
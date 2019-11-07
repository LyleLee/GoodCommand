atomic add
==================


##

解决办法：
```
cd tars2node
git am 0001-replace-atomic-x86-asm-code-with-gcc-builtin-__sync_.patch
cd build
cmake ../
make
```

https://github.com/tars-node/tars2node.git

参考资料：
[https://zhuanlan.zhihu.com/p/32303037](https://zhuanlan.zhihu.com/p/32303037)

相关问题
https://stackoverflow.com/questions/32470969/segfault-in-libc-upon-running-statically-linked-application
https://www.cnblogs.com/silentNight/p/5685629.html
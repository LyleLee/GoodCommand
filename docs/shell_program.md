shell编程常用参考
=================

[正则表达式例子](https://www.cnblogs.com/zxin/archive/2013/01/26/2877765.html)  
[shell 测试文件运算符](https://www.tldp.org/LDP/abs/html/fto.html)  
[shell 整数比较，字符串比较](https://www.tldp.org/LDP/abs/html/comparison-ops.html)  
[shell 字符串操作](https://www.tldp.org/LDP/abs/html/string-manipulation.html)  
[shell 之 提取文件名和目录名的一些方法](https://blog.csdn.net/ljianhui/article/details/43128465)
算数表达式
```
r=$(( 40 - 5 ))
```
文件描述符
```
exec 3<> /tmp/foo # open fd 3.
echo a >&3 # write to it
exec 3>&- # close fd 3.
```
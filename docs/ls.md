ls 获取文件路径全名
====================
```
alias full='_full(){ ls $PWD/$1; };_full'
[me@centos go]$ full LICENSE
/home/me/go/LICENSE
```
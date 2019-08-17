devtoolset
====================
可以非常方便地安装各种版本GCC

```
yum search centos-release
yum reinstall centos-release-scl-rh.noarch
yum install devtoolset-8
scl enable devtoolset-7 bash
scl enable devtoolset-8 bash
```

遇到过一个问题， 先安装centos-release-scl.noarch之后再安装centos-release-scl-rh.noarch导致查找不到devtoolset安装包
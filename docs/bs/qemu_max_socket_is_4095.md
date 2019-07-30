qemu max socket is 4095
================

使用qemu时出现最大socket报错：


## ubuntu 上的报错

Error polling connection 'qemu:///system': internal error: Socket 5418 can't be handled (max socket is 4095)

![](https://launchpadlibrarian.net/405637969/error_virt.png)

[](https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1811198)

## CentOS上的报错



## 解决办法


[https://www.redhat.com/archives/libvir-list/2018-August/msg00798.html
SELinux
==============
SELinux是CentOS和redhat的安全特性。  遇到一个问题，使用httpd或者时nginx设置在线软件源的时候，会出现符号链接不可用。  
nginx会报：
```
403 Forbidden
```
httpd会报
```
403 Forbidden : You don't have permission to access / on this server
```
如果不关闭，autoindex， FollowSymLinks等参数不用。在找不到网页时无法列出目录。复制过来的目录也没有访问权限。



```CS
/usr/sbin/sestatus -v       #查看SElinux状态，如果SELinux status参数为enabled即为开启状态
SELinux status:                 enabled
getenforce                  #查看SElinux状态
setenforce 0                #临时关闭SElinux,设置SELinux 成为permissive模式
setenforce 1                #启用SELinux，设置SELinux 成为enforcing模式
```
永久关闭SELinux
```
vim /etc/selinux/config

SELINUX=enforcing 修改为
SELINUX=disabled
#重启机器即可
```

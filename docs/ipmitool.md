ipmitool
=========
好像是一种管理工具。可以连接到服务器的串口输出
```
ipmitool -I lanplus -H 192.168.2.151 -U Administrator -P Adminpasscode sol activate
```
192.168.2.151 是IP地址  
Administrator 是用户名  
Adminpasscode 是密码  

当发现ipmi无法使用时，可以另起session，kill掉现在的连接
```
ipmitool -I lanplus -H 192.168.2.151 -U Administrator -P Adminpasscode sol deactivate
```
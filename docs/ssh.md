ssh
=====================
ssh 是非常普遍的登录方式


ubuntu 默认情况下是不允许root用户通过ssh登录的。  
修改/etc/ssh/sshd_config
```
PermitRootLogin yes
```
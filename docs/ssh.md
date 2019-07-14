ssh
=====================
ssh 是非常普遍的登录方式


ubuntu 默认情况下是不允许root用户通过ssh登录的。  
修改/etc/ssh/sshd_config
```
PermitRootLogin yes
```

## 远程执行任务
```
ssh nick@xxx.xxx.xxx.xxx "df -h" 						#执行普通命令
ssh nick@xxx.xxx.xxx.xxx -t "top"						#执行交互命令
ssh nick@xxx.xxx.xxx.xxx < test.sh						#在远程主机上执行本地脚本
ssh nick@xxx.xxx.xxx.xxx 'bash -s' < test.sh helloworld	#在远程主机上执行待参数的本地脚本
ssh nick@xxx.xxx.xxx.xxx "/home/nick/test.sh"			#在远程主机上执行远程主机上的脚本
```
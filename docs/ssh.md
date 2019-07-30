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

## 批量执行远程任务
很多时候希望在很多主机上批量执行任务

```
pdsh -w ^all.txt -R ssh "uptime"
```

all.txt保存主机IP列表
```
192.168.100.101
192.168.100.102
192.168.100.103
192.168.100.104
192.168.100.105
192.168.100.106
192.168.100.107
192.168.100.108
```

所有得主机都应该设置免密登录，也就是ssh可以直接登录主机
```
ssh 192.168.100.101
```

## 登陆失败后添加到黑名单
[https://www.cnblogs.com/panblack/p/secure_ssh_auto_block.html](https://www.cnblogs.com/panblack/p/secure_ssh_auto_block.html)

## 设置免密登录

```
ssh-keygen
ssh-copy-id 192.168.100.101
```


## 禁止使用用户密码登录
```diff
diff --git a/etc/ssh/sshd_config b/sshd_config
index 3194915..12a0d77 100644
--- a/etc/ssh/sshd_config
+++ b/sshd_config
@@ -62,7 +62,7 @@ AuthorizedKeysFile    .ssh/authorized_keys
 # To disable tunneled clear text passwords, change to no here!
 #PasswordAuthentication yes
 #PermitEmptyPasswords no
-PasswordAuthentication yes
+PasswordAuthentication no

 # Change to no to disable s/key passwords
 #ChallengeResponseAuthentication yes
```

禁止后效果
```

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Session stopped
    - Press <return> to exit tab
    - Press R to restart session
    - Press S to save terminal output to file

Disconnected: No supported authentication methods available (server sent: publickey,gssapi-keyex,gssapi-with-mic)

```

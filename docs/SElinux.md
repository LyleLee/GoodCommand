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
在文件/var/log/audit/audit.log可以查看到denied请求：
```
type=AVC msg=audit(1560175301.653:7102): avc:  denied  { read } for  pid=30807 comm="nginx" name="hisi" dev="dm-0" ino=101710253 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:home_root_t:s0 tclass=dir permissive=0
type=SYSCALL msg=audit(1560175301.653:7102): arch=c00000b7 syscall=56 success=no exit=-13 a0=ffffffffffffff9c a1=aaaafff50290 a2=84800 a3=0 items=0 ppid=30804 pid=30807 auid=4294967295 uid=995 gid=991 euid=995 suid=995 fsuid=995 egid=991 sgid=991 fsgid=991 tty=(none) ses=4294967295 comm="nginx" exe="/usr/sbin/nginx" subj=system_u:system_r:httpd_t:s0 key=(null)
type=PROCTITLE msg=audit(1560175301.653:7102): proctitle=6E67696E783A20776F726B65722070726F63657373
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

# 安装必要的SELinux策略管理工具
```
yum install -y policycoreutils-python setroubleshoot
```

# 重置SELinux策略到默认状态
```
$> touch /.autorelabel
$> reboot
```
This action will return the SELinux policies to their default. After reboot we’re ready to continue configuring our policies.
# 查看SELinux的内置策略
To see a list of all built-in policy booleans you can use  
```
getsebool -a
```
启用内置规则
```
setsebool -P httpd_can_network_connect=1
```

# 查看失败的认证请求
```
cat /var/log/audit/audit.log | grep fail
```

# 查看失败原因
```
grep nginx /var/log/audit/audit.log | audit2why
```

# 创建SELinux策略
```
grep nginx audit.log | audit2allow -M nginxpolicy
semodule -i nginxpolicy.pp
```
## 设置.bash_history
在命令行使用history可以查看当前用户执行过的命令，可以很方便地帮助我们回忆做了什么事情。history命令的输出其实是在`~/.bash_history`文件中保存的。
默认情况下保存命令的条数是有限的。可以通过修改一些参数来进行定制。  

以下在是在ubuntu18.04中的设置，其他linux应该改大同小异。 配置文件是：
 
+ `/etc/profile` 计算机全局生效，所有用户都有影响  
+ `~/.bashrc` 当前用户生效

### 查看当前配置
可以打开上述文件，或者使用echo查看当前的设置：
```shell
#查看hisotry命令每次输出最大记录
echo $HISTSIZE
#查看.bash_history文件最大记录
echo $HISTFILESIZE
#查看历史记录时间格式
echo $HISTTIMEFORMAT
#查看历史记录保存文件
echo $HISTFILE
```
### 添加配置
这里修改`/etc/profile`追加以下内容：
```shell
#设置文件最大记录
HISTFILESIZE=20000
#设置时间格式，使用history命令时会输出时间
HISTTIMEFORMAT="%F %T "
#用户多个终端时，共享history
shopt -s histappend
#实时追加history，默认是用户退出时才刷新history
PROMPT_COMMAND="history -a"
```
退出终端，重新登录生效 或者：
```shell
source /etc/profile
```

###配置结果

```shell-session
me@ubuntu:~$ #查看hisotry命令每次输出最大记录
me@ubuntu:~$ echo $HISTSIZE
10000
me@ubuntu:~$ #查看.bash_history文件最大记录
me@ubuntu:~$ echo $HISTFILESIZE
20000
me@ubuntu:~$ #查看历史记录时间格式
me@ubuntu:~$ echo $HISTTIMEFORMAT
%F %T
me@ubuntu:~$ #查看历史记录保存文件
me@ubuntu:~$ echo $HISTFILE
/home/me/.bash_history
```
```shell-session
me@ubuntu:~$history
 3943  2019-02-18 16:18:21 echo $HISTSIZE
 3944  2019-02-18 16:18:21 #查看.bash_history文件最大记录
 3945  2019-02-18 16:18:21 echo $HISTFILESIZE
 3946  2019-02-18 16:18:21 #查看历史记录时间格式
 3947  2019-02-18 16:18:21 echo $HISTTIMEFORMAT
 3948  2019-02-18 16:18:21 #查看历史记录保存文件
 3949  2019-02-18 16:18:23 echo $HISTFILE
 3950  2019-02-18 16:18:32 history --help
 3951  2019-02-18 16:19:45 history
 3952  2019-02-18 16:19:48 history
```

### cat正常 vim中文乱码
在.vimrc中添加
```config
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
```
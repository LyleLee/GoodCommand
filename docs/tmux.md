tmux 终端复用工具
============================
tmux是终端复用工具，是终端中的神器。 使用tmux可以把一个终端变成一个终端，这样就不需要在多个图形终端中切换来切换去，也不需要担心因为终端关闭而终止前台运行的程序。使用tmux创建一个session之后可以保留到你想关闭为止。下次只需要tmux a就可以恢复所有未关闭的session。

## 配置文件路径
全局配置文件路径为,没有请创建
```
/etc/tmux.conf
```
当前用户配置文件路径为，没有请创建
```
~/.tmux.conf
```
导出默认的配置文件
```
tmux show -g > a.txt
```

两个非常有用的教程：
https://wiki.ipfire.org/addons/tmux/start
https://gist.github.com/dbeckham/655da225f1243b2db5da


## 问题
不要听信网上的谣言使用
```
set -g mouse on
```
我用的时候mobaxterm就无法用鼠标复制了
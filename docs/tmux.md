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

## 交换窗口顺序

3号窗口交换到1号窗口
```
ctrl + b
:swap-window -s 3 -t 1
```
当前窗口交换到0号窗口
```
ctrl + b
:swap-window -t 0
```

## 进入与退出tmux
实际上退出的优雅方式是detached当前的session。tmux仍在后台运行，连接到终端上。  

分离session
```
ctrl b
d
```

例如有一个session 0包含5个windows：
```
tmux ls

0: 5 windows (created Tue Mar 26 14:42:20 2019) [171x47]
```
挂接session
```
tmux a
tmux attach
tmux a -t 0
tmux attach-session -t 0 #这几个命令等效，挂接session 0，包含5个windows
```
重命名session
```
# 在tmux界面
ctrl b
$
#在shell界面
tmux rename-session [-t current-name] [new-name]
```
切换到另一个session
```
ctrl b
:choose-session
上下箭头选择
enter
```

## 问题
不要听信网上的谣言使用
```
set -g mouse on
```
我用的时候mobaxterm就无法用鼠标复制了


## 参考
两个非常有用的教程：  
https://wiki.ipfire.org/addons/tmux/start  
https://gist.github.com/dbeckham/655da225f1243b2db5da
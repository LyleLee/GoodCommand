======================
tmux
======================

tmux是终端复用工具，是终端中的神器。
使用tmux可以把一个终端变成一个终端，这样就不需要在多个图形终端中切换来切换去，也不需要担心因为终端关闭而终止前台运行的程序。使用tmux创建一个session之后可以保留到你想关闭为止。下次只需要tmux
a就可以恢复所有未关闭的session。

配置文件
--------

::

   /etc/tmux.conf                  全局配置文件路径为,没有请创建
   ~/.tmux.conf                    当前用户配置文件路径为，没有请创建
   tmux show -g > a.txt            导出默认的配置文件
   tmux source-file ~/.tmux.conf   重新加载配置文件

   ctrl + b                        tmux 界面重新加载配置文件
   :source-file ~/.tmux.conf

我的配置文件：

::

   set -g default-terminal "screen-256color"
   set-option -g allow-rename off
   set -g status-right "#{=21:pane_title} #(date \"+%Y-%m-%d %H:%M:%S\")"
   setw -g mode-keys vi

禁止tmux重命名标签页

::

   set allow-rename off
   set-option -g allow-rename off
   set -g status-keys vi
   set -g history-limit 10000

交换窗口顺序
------------

3号窗口交换到1号窗口

::

   ctrl + b
   :swap-window -s 3 -t 1

当前窗口交换到0号窗口

::

   ctrl + b
   :swap-window -t 0

分离session

::

   ctrl b
   d

例如有一个session 0包含5个windows：

::

   tmux ls

   0: 5 windows (created Tue Mar 26 14:42:20 2019) [171x47]

挂接session

::

   tmux a
   tmux attach
   tmux a -t 0
   tmux attach-session -t 0 #这几个命令等效，挂接session 0，包含5个windows

结束session

::

   ctrl b; :kill-session          #在tmux界面，进入tmux交互，输入kill-session
   tmux kill-session -t 会话名    #在shell界面，指定要kill的session

重命名session

::

   # 在tmux界面
   ctrl b
   $
   #在shell界面
   tmux rename-session [-t current-name] [new-name]

切换到另一个session

::

   ctrl b
   :choose-session
   上下箭头选择，横向选中
   enter

新建session：

::

   ctrl b
   new -s sname        #在tmux界面，新建session
   tmux new -s sname   #在shell界面新建session

pannel
------

::

   ctrl+b, "   #水平分割当前panel
   ctrl+b, %   #垂直分割当前panel
   ctrl+b, ←↑→ #在panel之间切换
   ctrl+b, o   #在panel之间切换
   ctrl+b, z   #当前panel最大化，或者是恢复panel

复制
----

::

   使用如下配置文件之后， 按住shift可以实现选中终端内容复制到系统剪贴板。

.. _配置文件-1:

配置文件
--------

::

   # Make mouse useful in copy mode
   setw -g mode-mouse on

   # Allow mouse to select which pane to use
   set -g mouse-select-pane on

   # Allow mouse dragging to resize panes
   set -g mouse-resize-pane on

   # Allow mouse to select windows
   set -g mouse-select-window on

   # Allow xterm titles in terminal window, terminal scrolling with scrollbar, and setting overrides of C-Up, C-Down, C-Left, C-Right
   # (commented out because it disables cursor navigation in vim)
   #set -g terminal-overrides "xterm*:XT:smcup@:rmcup@:kUP5=\eOA:kDN5=\eOB:kLFT5=\eOD:kRIT5=\eOC"

   # Scroll History
   set -g history-limit 30000

   # Set ability to capture on start and restore on exit window data when running an application
   setw -g alternate-screen on

   # Lower escape timing from 500ms to 50ms for quicker response to scroll-buffer access.
   set -s escape-time 50

问题
----

不要听信网上的谣言使用

::

   set -g mouse on

我用的时候mobaxterm就无法用鼠标复制了

参考
----

| tmux 命令：
| http://hyperpolyglot.org/multiplexers
| 两个非常有用的教程： https://wiki.ipfire.org/addons/tmux/start
| https://gist.github.com/dbeckham/655da225f1243b2db5da

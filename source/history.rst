history
=======

使用history命令可以查看历史命令。

现在默认的bash在多个终端窗口的表现是：

在窗口1执行

::

   ls
   rm foo -rf
   pwd

在窗口2执行

::

   git commit 
   git clone
   git log

在窗口3执行

::

   ./configure
   make
   make install

依次关闭窗口1、2，3，重新打开一个窗口， 这个新窗口只会保留窗口3的内容。

我们希望history保留所有窗口的内容。
好处，不会漏。坏处，在新窗口看到的命令比较乱。

::

   vim ~/.bashrc

.. code:: conf

   # Avoid duplicates
   export HISTCONTROL=ignoredups:erasedups  
   # When the shell exits, append to the history file instead of overwriting it
   shopt -s histappend

   # After each command, append to the history file and reread it
   export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

参考资料
--------

`【https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows】 <https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows>`__

alias 设置命令别名
======================


.. code:: 

   pi@raspberrypi:~ $ alias -p
   alias du='du -h --max-depth=1'
   alias egrep='egrep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias grep='grep --color=auto'
   alias ls='ls --color=auto'

alias只对当前shell有效，推出后不起作用。可以写到~/.bashrc中使自动生效

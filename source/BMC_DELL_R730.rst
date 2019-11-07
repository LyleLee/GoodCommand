R730 BMC 关机开机操作
=====================

当不在机房的时候，可以ssh到BMC界面，在BMC命令行执行以下语句：

::

   racadm serveraction powerup                                         #开启服务器
   racadm serveraction powerdown                                       #关闭服务器
   racadm serveraction powercycle                                      #关机后再开启服务器
   racadm serveraction powerstatus                                     #查看服务器状

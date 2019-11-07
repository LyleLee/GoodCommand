aria2 下载工具
==============

安装
====

::

   apt install aria2

配置
====

文件文件位于

::

   /etc/aria2/aria2.conf

主要配置下载目录

::

   dir=/home/download

配置webui需要nginx配合 安装nginx之后，
把Aria2WebUI的压缩包解药到/var/www/即可

::

   pi@linux:/etc/aria2 $ ls /var/www
   html  htmlx.zip

启动
====

aria2使用systemd管理，aria2会监听6800端口

::

   systemctl start aria2

启用Aria2WebUI，需要看到UI之后配置连接端口到6800，如果有用户和密码，则需要进行相应配置

::

   systemctl start nginx

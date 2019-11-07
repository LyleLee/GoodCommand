ubuntu 远程桌面
===============

通常服务器安装的server版是没有桌面系统的，
如果想要给服务器安装桌面环境怎么办。

ubuntu-desktop 桌面环境
-----------------------

Ubuntu的桌面环境很多，genome，unity等，其实我也记不住，也不想用😅，所以装默认的吧

::

   sudo apt-get install ubuntu-desktop

如果发现无法下载某些包怎么办，特别是使用国内软件源的时候，可能会出现下面的错误。

::

   Unable to correct missing packages.
   E: Failed to fetch https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/g/ghostscript/libgs9-common_9.26~dfsg+0-0ubuntu0.18.04.7_all.deb  Undetermined Error [IP: 117.78.24.36 443]
   E: Failed to fetch https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/g/ghostscript/libgs9_9.26~dfsg+0-0ubuntu0.18.04.7_arm64.deb  Undetermined Error [IP: 117.78.24.36 443]
   E: Failed to fetch https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/g/ghostscript/ghostscript_9.26~dfsg+0-0ubuntu0.18.04.7_arm64.deb  Undetermined Error [IP: 117.78.24.36 443]
   E: Failed to fetch https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/libg/libgd2/libgd3_2.2.5-4ubuntu0.3_arm64.deb  Undetermined Error [IP: 117.78.24.36 443]
   E: Failed to fetch https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/f/firefox/firefox_65.0.1+build2-0ubuntu0.18.04.1_arm64.deb  Undetermined Error [IP: 117.78.24.36 443]
   E: Failed to fetch https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/g/ghostscript/ghostscript-x_9.26~dfsg+0-0ubuntu0.18.04.7_arm64.deb  Undetermined Error [IP: 117.78.24.36 443]
   E: Failed to fetch https://mirrors.huaweicloud.com/ubuntu-ports/pool/main/t/thunderbird/thunderbird_60.5.1+build2-0ubuntu0.18.04.1_arm64.deb  File has unexpected size (3145728 != 33795760). Mirror sync in progress? [IP: 117.78.24.36 443]

这个时候可以

::

   sudo apt-get install ubuntu-desktop --fix-missing

| 如果还是不行，怎么办，很可能是国内的源没有完全同步软件包。这个时候前面配置软件源的教程\ `ubuntu配置软件源 <ubuntu_sources_list.md#_2>`__\ 备份的sources.list就起作用了。
| 把备份的文件复制一份到sources.list.d目录下，并且命名需要是.list。

.. code:: shell-session

   sudo cp /etc/apt/sources.list.backup /etc/apt/sources.list.d/sources.list
   sudo apt-get update
   sudo apt-get install ubuntu-desktop

这个时候就可以了。

| 另外所有的安装包加起来很大，下载需要很久，我就遇到了firefox从美国地址下载的情况，这个时候ctrl+c停止，在\ https://launchpad.net\ 查找对应软件包并下载。
| 例如firefox的下载地址是\ https://launchpad.net/ubuntu/bionic/arm64/firefox/65.0.1+build2-0ubuntu0.18.04.1
  下载后使用dpkg命令安装

::

   sudo dpkg -i firefox_65.0.1+build2-0ubuntu0.18.04.1_arm64.deb

出现依赖问题安装停止时执行

::

   sudo apt-get -f install

远程桌面
--------

有了桌面环境了，但是服务器其实不在我们身边，无法插上显示器查看桌面环境，这个时候可以配置远程桌面登录，方法有很多vnc,teamviewer等，但是我还是喜欢windows自带的远程桌面。未了让windows的远程桌面能连接到服务器，需要配置服务端环境。

::

   sudo apt-get install xrdp

安装成功后，可以看到xrdp的监听端口。

.. code:: shell-session

   root@ubuntu:~# netstat -antup | grep xrdp
   tcp6       0      0 ::1:3350                :::*                    LISTEN      54713/xrdp-sesman
   tcp6       0      0 :::3389                 :::*                    LISTEN      54735/xrdp
   tcp6       0      0 127.0.0.1:3389          127.0.0.1:37756         ESTABLISHED 58139/xrdp #这里时我已经脸上才出现的
   root@ubuntu:~#

请注意需要防火墙放行,或者直接禁掉.

::

   sudo ufw disable

如果服务器处于NAT之内，可以考虑在网关上做端口映射，把3389暴露出去。

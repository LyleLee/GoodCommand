***************************************
board_connect
***************************************

board_connect 是内部链接单板的工具。但是有时候发现无法链接上。

.. code:: shell-session

   lixianfa@BoardServer2:~$ board_connect 4
   /home/lixianfa/grub.cfg  #sync to#  /home/hisilicon/ftp/grub.cfg-01-00-18-c0-a8-02-81
   Connected to board: No=185, type=D05.
   Info: SOL payload already de-activated
   [SOL Session operational.  Use ~? for help]

这个时候需要修改grub启动项。

Redhat-D06
==========

编辑/etc/default/grub添加console=ttyAMA0,115200
完整的/etc/default/grub如下：

::

   GRUB_TIMEOUT=5
   GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
   GRUB_DEFAULT=saved
   GRUB_SAVEDEFAULT=true
   GRUB_DISABLE_SUBMENU=true
   GRUB_TERMINAL_OUTPUT="console"
   GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap rhgg
   b quiet console=ttyAMA0,115200"
   GRUB_DISABLE_RECOVERY="true"

更新grub.cfg:

.. code:: shell

   grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg #务必注意grub.cfg的路径是否是这个路径。

Ubuntu 18.04.1 LTS-D05
======================

编辑/etc/default/grub添加console=ttyAMA0,115200
完整的/etc/default/grub如下：

::

   GRUB_DEFAULT=saved
   GRUB_TIMEOUT_STYLE=hidden
   GRUB_TIMEOUT=2
   GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
   GRUB_CMDLINE_LINUX_DEFAULT=""
   GRUB_CMDLINE_LINUX="console=ttyAMA0,115200"

更新grub.cfg:

::

   sudo grub-mkconfig -o /boot/grub/grub.cfg

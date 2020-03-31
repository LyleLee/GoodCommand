**********************
grub
**********************

如何设置启动选项
=================

RedHat保存本次设置，作为下次的默认启动项. 需要设置这两项。 选中什么下次启动仍然是这个启动项

::

   GRUB_DEFAULT=saved
   GRUB_SAVEDEFAULT=true


RedHat
=================

grub模板位置

.. code-block:: console

   /etc/default/grub

grub.cfg位置

.. code-block:: console

   /boot/efi/EFI/redhat/grub.cfg

修改/etc/default/grub后更新命令

.. code-block:: console

   grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg


CentOS 7 1810
=================
grub模板位置

.. code-block:: console

   /etc/default/grub

grub.cfg位置

.. code-block:: console

   /boot/grub2/grub.cfg

修改/etc/default/grub后更新命令

.. code-block:: console

   grub2-mkconfig -o /boot/grub2/grub.cfg




ubuntu 18.04 LTS
==================

grub模板位置

.. code-block:: console

   /etc/default/grub

grub.cfg位置

.. code-block:: console

   /boot/grub/grub.cfg

修改/etc/default/grub后更新命令

.. code-block:: console

   sudo grub-mkconfig -o /boot/grub/grub.cfg


查看系统已有的开机启动项：

.. code::

   grep "^menuentry" /boot/efi/EFI/redhat/grub.cfg
   # 需要以menuentry开头

   $ sudo grub-set-default 0
   上面这条语句将会持续有效，直到下一次修改；下面的命令则只有下一次启动的时候生效：

   $ sudo grub-reboot 0
   将下次选择的启动项设为默认


grub官方文档：https://www.gnu.org/software/grub/manual/grub/grub.html#Introduction

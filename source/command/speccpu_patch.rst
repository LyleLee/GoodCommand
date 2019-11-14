**********************
speccpu patch
**********************

合入针对ARM的更改，使speccpu编译成功

合入更改：
~~~~~~~~~~

**方法1：** 切换到cpu2006 ISO文件解压的根目录执行

::

   patch -R -p1 all_in_one.patch

有可能提示需要对应文件或这目录的写入权限。

::

   chmod +w 目录名/文件名

patch下载地址 :download:`../resources/all_in_one.patch`

**方法2：** 切换到cpu2006 git目录执行

::

   git am --abort #保证上次合入操作停止
   git am 0001-modify-to-make-compile-success.patch

如果提示权限不足，请修改文件权限或者使用sudo命令
patch下载地址 :download:`../resources/0001-modify-to-make-compile-success.patch`

编译
~~~~

执行编译前，可能需要修改某些目录和文件的权限

::

   sudo chmod +w tools/src -R
   sudo chmod +w tools
   sudo chmod +w config
   sudo chmod +w MANIFEST

执行编译

::

   cd tools/src/
   /buildtools

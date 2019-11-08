diff 比较文件差异
=================

有时候我们希望比较文件差异，或者目录结构差异。

以左右对比方式显示请使用：sdiff或者使用diff -y参数

::

   sdiff old new
   diff old new

以着色方式对比显示请使用：colordiff

.. code::

   colordiff -u old new 
   diff -u old new | colordiff

   -u #表示已合并格式显示

比较文件差异
------------

比较src目录下的文件差异，递归比较子目录-r;同时不显示差异的文件内容，仅显示文件名-q;同时希望排除目标文件

.. code:: shell

   diff -qr  -x "*.o" specpu2006_test_from_iso/tools/src specpu2006_test_from_tar/tools/src

.. code:: diff

   Only in specpu2006_test_from_tar/tools/src/tar-1.25/gnu: ref-add.sed
   Only in specpu2006_test_from_tar/tools/src/tar-1.25/gnu: ref-del.sed
   Only in specpu2006_test_from_tar/tools/src/tar-1.25/gnu: stdio.h
   Files specpu2006_test_from_iso/tools/src/tar-1.25/gnu/stdio.in.h and specpu2006_test_from_tar/tools/src/tar-1.25/gnu/stdio.in.h differ
   Only in specpu2006_test_from_tar/tools/src/tar-1.25/gnu: stdlib.h
   Only in specpu2006_test_from_tar/tools/src/tar-1.25/gnu: string.h
   Only in specpu2006_test_from_tar/tools/src/tar-1.25/gnu: strings.h

只关心改动的文件，不关心新增或者缺少的文件。加一个grep就可以了。同时希望结果漂亮点column
-t

::

   diff -qr -x "*.o" specpu2006_test_from_iso/tools/src specpu2006_test_from_tar/tools/src | grep differ | column -t

.. code:: diff

   Files  specpu2006_test_from_iso/tools/src/buildtools                 and  specpu2006_test_from_tar/tools/src/buildtools                 differ
   Files  specpu2006_test_from_iso/tools/src/make-3.82/glob/glob.c      and  specpu2006_test_from_tar/tools/src/make-3.82/glob/glob.c      differ
   Files  specpu2006_test_from_iso/tools/src/perl-5.12.3/Configure      and  specpu2006_test_from_tar/tools/src/perl-5.12.3/Configure      differ
   Files  specpu2006_test_from_iso/tools/src/specsum/gnulib/stdio.in.h  and  specpu2006_test_from_tar/tools/src/specsum/gnulib/stdio.in.h  differ
   Files  specpu2006_test_from_iso/tools/src/tar-1.25/gnu/stdio.in.h    and  specpu2006_test_from_tar/tools/src/tar-1.25/gnu/stdio.in.h    differ

左右格式显示，不显示相同行

生成patch文件和打patch
----------------------

生成patch保存到文件

::

   diff -ruaN sources-orig/ sources-fixed/ >myfixes.patch

合入patch

::

   cd sources-orig/
   patch -p1 < ../myfixes.patch
   patching file officespace/interest.go

回滚patch，打了patch之后后悔了，希望不要打patch

::

   patch -R < myfixes.patch

多个文件生成一个patch
---------------------

.. code:: shell

   diff -ruaN path/file1.c /path/file2.c >> all_in_one.path
   diff -ruaN path/filea.c /path/fileb.c >> all_in_one.path

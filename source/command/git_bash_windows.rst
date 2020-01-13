*************************
git bash windows
*************************

git bash 显示中文乱码
=======================

::

   $ git status
   On branch master
   Your branch is up to date with 'origin/master'.

   Changes to be committed:
     (use "git reset HEAD <file>..." to unstage)

           new file:   .gitignore
           new file:   Makefile
           new file:   make.bat
           new file:   source/KVM.md
           new file:   "source/ceph\346\265\213\350\257\225\345\221\275\344\273\244.md"
           new file:   "source/ceph\346\265\213\350\257\225\345\221\275\344\273\244_FS.md"
           new file:   source/conf.py
           new file:   source/index.rst
           new file:   "source/\345\246\202\344\275\225\344\275\277\347\224\250\347\224\237\346\210\220\346\226\207\346\241\243.md"
           new file:   "source/\346\237\245\347\234\213CPU\345\222\214\345\206\205\345\255\230\345\244\247\345\260\217.md"

| 解决办法
| #### 1. git bash option 设置中文支持

::

   git bash 界面右键→option→Text→local设置为zh_CN,Character Set设置为UTF-8

git bash option 设置中文支持
==============================

::

   git config --global i18n.commitencoding utf-8
   git config --global core.quotepath false

设置windows unix文件格式
==============================

Checkout Windows-style, commit Unix-style [#commit_unix_style]_

Git will convert LF to CRLF when checking out text files. When committing text files, CRLF will be converted to LF. For cross-platform projects, this is the recommended setting on Windows ("core.autocrlf" is set to "true")

Checkout as-is, commit Unix-style

Git will not perform any conversion when checking out text files. When committing text files, CRLF will be converted to LF. For cross-platform projects this is the recommended setting on Unix ("core.autocrlf" is set to "input").

Checkout as-is, commit as-is

Git will not perform any conversions when checking out or committing text files. Choosing this option is not recommended for cross-platform projects ("core.autocrlf" is set to "false")

.. [#commit_unix_style] https://stackoverflow.com/questions/10418975/how-to-change-line-ending-settings

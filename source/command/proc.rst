***********************
proc
***********************

man 手册的内容 [#man-proc]_

NAME
    proc - process information pseudo-filesystem

    proc - 进程信息伪文件系统

DESCRIPTION
    The  proc  filesystem is a pseudo-filesystem which provides an interface to kernel data structures.  It is commonly mounted at /proc.
    Typically, it is mounted automatically by the system,
    but it can also be mounted manually using a command such as:

    proc文件系统是一个伪文件系统, 它提供了一个到内核数据结构的接口。 它通常挂载在 /proc。通常情况下系统会自动挂载它。
    但是用以下命令也能挂载

        mount -t proc proc /proc

    Most of the files in the proc filesystem are read-only, but some files are writable, allowing kernel variables to be changed.


实际尝试了一下::

    user1@intel6248:~$ mkdir fakeproc
    user1@intel6248:~$ sudo mount -t proc proc ./fakeproc

这个ls fakeproc目录就可以看到进程的信息了 ::

    user1@intel6248:~$ ls fakeproc/
    1      1124   1201   133    1435   153    166    1871   204    2213   24324  270    305    336    366    399    432    464    5001   586    64320  73937  81     874   9719         locks
    10     1125   1202   135    1436   154    167    18731  2044   222    244    272    3053   338    3677   4      434    465    501    587    65     74     816    88    98           mdstat
    100    1127   1203   1350   1437   155    168    1877   2049   22283  24430  273    306    339    368    40     435    466    502    5897   652    74081  81692  8814  99           meminfo


.. [#man-proc] https://man7.org/linux/man-pages/man5/proc.5.html
autotool GNU软件构建工具
===========================

GNU软件标准Makefile 目标
--------------------------

``make all`` 编译程序，库，文档等。 和make表现一样

``make install`` 安装需要被安装的程序

``make install-strip`` 和make install 一样，但是要strip debugging symbol

``make uninstall`` 和make install 相反的目的

``make clean`` 和make all相反的目的，删除编译好的目标

``make distclean`` 同事删除./configure产生的文件

``make check`` 如果有测试套件，执行测试套件

``make installcheck`` 检查已经安装的程序和库

``make dist`` 生成 name-version.tag.gz

GNU软件项目标准文件组织
------------------------

::

   Directory variable Default value
   prefix                  /usr/local
           exec-prefix     prefix
               bindir      exec-prefix/bin
               libdir      exec-prefix/lib
   ...
           includedir      prefix/include
           datarootdir     prefix/share
               datadir     datarootdir
               mandir      datarootdir/man
               infodir     datarootdir/info

在configure的时候指定prefix

::

   ./configure --prefix ~/usr

configure中定义的变量：

::

   CC          C compiler command
   CFLAGS      C compiler flags
   CXX         C++ compiler command
   CXXFLAGS    C++ compiler flags
   LDFLAGS     linker flags
   CPPFLAGS    C/C++ preprocessor flags
   ... See ‘./configure --help’ for a full list

::

   ./configure --prefix ~/usr CC=gcc-3 CPPFLAGS=-I$HOME/usr/include LDFLAGS=-L$HOME/usr/lib

创建build目录的目的是，中间过程生成的目标文件保存在build当中。

如果主机上已经有同名的目标文件

::

   --program-prefix=PREFIX     设置前缀名
   --program-suffix=SUFFIX     设置后缀名
   ‘--program-transform-name=PROGRAM’  run ‘sed PROGRAM’ on installed program names.
   ~/amhello-1.0 % ./configure --program-prefix test-
   ~/amhello-1.0 % make
   ~/amhello-1.0 % sudo make install

::

   yum install -y automake autoconf

GNU Autoconf
----------------

::

   ‘autoconf’ Create configure from configure.ac.
   ‘autoheader’ Create config.h.in from configure.ac.
   ‘autoreconf’ Run all tools in the right order.
   ‘autoscan’ Scan sources for common portability problems,and related macros missing from configure.ac.
   ‘autoupdate’ Update obsolete macros in configure.ac.
   ‘ifnames’ Gather identifiers from all #if/#ifdef/... directives.
   ‘autom4te’ The heart of Autoconf. It drives M4 and implements the features used by most of the above tools. 
               Useful for creating more than just configure files

GNU Automake
------------------

::

   ‘automake’ Create Makefile.ins from Makefile.ams and configure.ac.
   ‘aclocal’ Scan configure.ac for uses of third-party macros, and gather definitions in aclocal.m4.

configure.ac
------------------

::

   # Prelude.
   AC_INIT([amhello], [1.0], [bug-report@address])
   AM_INIT_AUTOMAKE([foreign -Wall -Werror])
   # Checks for programs.
   AC_PROG_CC
   # Checks for libraries.
   # Checks for header files.
   # Checks for typedefs, structures, and compiler characteristics.
   # Checks for library functions.
   # Output files.
   AC_CONFIG_HEADERS([config.h])
   AC_CONFIG_FILES([FILES])
   AC_OUTPUT

参考资料
-----------------

`【https://www.lrde.epita.fr/~adl/dl/autotools.pdf】 <https://www.lrde.epita.fr/~adl/dl/autotools.pdf>`__
`【autoconf】 <https://www.gnu.org/software/autoconf/manual/autoconf-2.67/html_node/index.html#Top>`__

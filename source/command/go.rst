***********************
go
***********************

编译安装golang

::

   yum install golang       #安装软件源默认的golang，用于编译新版本的golang
   git clone https://github.com/golang/go
   cd src
   ./all.bash

如果编译成功

::

   ##### ../test/bench/go1
   testing: warning: no tests to run
   PASS
   ok      _/home/me/go/test/bench/go1     1.914s

   ##### ../test

   ##### API check
   Go version is "go1.12.7", ignoring -next /home/me/go/api/next.txt

   ALL TESTS PASSED
   ---
   Installed Go for linux/arm64 in /home/me/go
   Installed commands in /home/me/go/bin
   *** You need to add /home/me/go/bin to your PATH.

设置path，注意替换成自己的路径

::

   [me@centos src]$ go version
   go version go1.11.5 linux/arm64
   [me@centos src]$ export PATH=/home/me/go/bin:$PATH
   [me@centos src]$ echo $PATH
   /home/me/go/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/me/.local/bin:/home/me/bin
   [me@centos src]$
   [me@centos src]$ go version
   go version go1.12.7 linux/arm64
   [me@centos src]$


go proxy
================

go 有时候需要使用代理才能访问

可以参考使用ssh tunnel，然后在终端

.. code-block:: shell

    export http_proxy=socks5://127.0.0.1:7777
    export https_proxy=socks5://127.0.0.1:7777

go build static
==================

::

   go build -a -ldflags '-extldflags "-static"'


怎么让go静态编译出目标文件 [#go_build]_


how to write Go code [必读]
=============================

https://golang.org/doc/code.html

package 必须在一个文件夹内，且一个文件夹内也只能有一个package，但是一个文件夹可以有多个文件 [#golang_package]_
文件名跟包名没有直接关系。如果只有一个文件，通常可以写成包名。但是导入的时候，必须导入包所在的文件夹的路径。其实可以这样理解，import 的是 path（路径） [#golang_package]_


怎么样组织golang工程文件  https://eli.thegreenplace.net/2019/simple-go-project-layout-with-modules/

问题记录
========

从源码安装go不成功
~~~~~~~~~~~~~~~~~~

::

   [2019-08-13 17:18:11]  [me@centos src]$ ./all.bash
   [2019-08-13 17:18:16]  Building Go cmd/dist using /home/me/go1.4.
   [2019-08-13 17:18:16]  ERROR: Cannot find /home/me/go1.4/bin/go.
   [2019-08-13 17:18:16]  Set $GOROOT_BOOTSTRAP to a working Go tree >= Go 1.4.

解决办法：

先安装默认版本的go

::

   yum install golang



.. [#go_build] http://blog.wrouesnel.com/articles/Totally%20static%20Go%20builds/
.. [#golang_package] https://www.jianshu.com/p/07ffc5827b26
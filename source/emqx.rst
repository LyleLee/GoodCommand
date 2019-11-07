编译安装emqx
============

emqx编译安装.emqx是一个MQTT消息服务器

1、编译安装Erlang
=================

emqx 依赖Erlang，需要先编译安装Erlang

首先安装依赖

::

   yum grouplist
   yum groupinstall "Development Tools"

再安装Erlang

::

   git clone https://github.com/erlang/otp.git
   cd otp
   git checkout -b OTP-22.0.7-build OTP-22.0.7
   ./otp_build autoconf
   ./configure
   make
   sudo make install

configure 报错请依次安装依赖包。参考问题列表。

sudo make install 成功会提示：

::

   erlang.mk:30: Please upgrade to GNU Make 4 or later: https://erlang.mk/guide/installation.html
    ERLC   ELDAPv3.erl eldap2.erl
    APP    eldap2.app.src
   make[1]: Leaving directory `/home/me/emqx-rel/_build/emqx/lib/eldap2'
   ===> Compiling emqx_auth_ldap
   ===> Starting relx build process ...
   ===> Resolving OTP Applications from directories:
             /home/me/emqx-rel/_build/emqx/lib
             /home/me/emqx-rel/_checkouts
             /usr/local/lib/erlang/lib
   ===> Resolved emqx-v3.2-beta.1-42-g663aee6
   ===> Including Erts from /usr/local/lib/erlang
   ===> release successfully created!
   [me@centos emqx-rel]$
   [me@centos emqx-rel]$

.. _编译安装emqx-1:

2. 编译安装emqx
===============

::

   git clone https://github.com/emqx/emqx-rel.git
   cd emqx-rel
   git checkout -b v3.2.2_build v3.2.2
   cd emqx-rel && make
   cd _build/emqx/rel/emqx && ./bin/emqx console

make
过程会fetch众多来自github的依赖包。Fetching不能失败，以避免编译后的emqx不能运行

::

   [2019-08-12 19:34:00]                           {branch,"master"}})
   [2019-08-12 19:34:00]  ===> Fetching emqx_auth_ldap (from {git,"https://github.com/emqx/emqx-auth-ldap",
   [2019-08-12 19:34:07]                            {branch,"master"}})
   [2019-08-12 19:34:07]  ===> Fetching emqx_auth_mongo (from {git,"https://github.com/emqx/emqx-auth-mongo",
   [2019-08-12 19:34:13]                             {branch,"master"}})
   [2019-08-12 19:34:13]  ===> Fetching emqx_auth_mysql (from {git,"https://github.com/emqx/emqx-auth-mysql",
   [2019-08-12 19:34:18]                             {branch,"master"}})
   [2019-08-12 19:34:18]  ===> Fetching emqx_auth_pgsql (from {git,"https://github.com/emqx/emqx-auth-pgsql",
   [2019-08-12 19:34:23]                             {branch,"master"}})
   [2019-08-12 19:34:23]  ===> Fetching emqx_auth_redis (from {git,"https://github.com/emqx/emqx-auth-redis",
   [2019-08-12 19:34:29]                             {branch,"master"}})
   [2019-08-12 19:34:29]  ===> Fetching emqx_auth_username (from {git,"https://github.com/emqx/emqx-auth-username",

console执行成功会有如下提示： |image0| 打开web界面无报错 |image1|

遇到问题记录：
==============

问题1：Tomcat提示启动成功，当时没有后台进程
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`【tomcat not start】 <tomcat_not_start.md>`__

问题2：escript: No such file or directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   /usr/bin/env: escript: No such file or directory

   make: *** [get-deps] Error 127

  解决办法：

编译安装erlang

问题3：rebar3执行bootstrap报错
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   [root@izuf66apgccn7tpnaw8k8lz rebar3]# ./bootstrap
   /usr/local/rebar3/_build/default/lib/parse_trans/src/ct_expand.erl:206: illegal guard expression

解决办法：

`【https://github.com/erlang/rebar3/issues/2059】 <https://github.com/erlang/rebar3/issues/2059>`__

安装新版本Erlang：

::

   It has not been supported for over a year since it is now almost 6 years old (OTP-22 should be out in a couple of months at the most); there's one breaking release a year, and 3 minor releases a year as well. Release 3.5.2 is the last one to support R16: https://github.com/erlang/rebar3/releases/tag/3.5.2

   You may fetch one of these older versions if you must.

问题4： 缺少OpenGL
~~~~~~~~~~~~~~~~~~

::

   configure: WARNING: No OpenGL headers found, wx will NOT be usable
   configure: WARNING: No GLU headers found, wx will NOT be usable

http://www.prinmath.com/csci5229/misc/install.html

::

   yum install freeglut-devel

问题5： 缺少 wxWidgets
~~~~~~~~~~~~~~~~~~~~~~

::

   ./configure: line 4661: wx-config: command not found
   configure: WARNING:
                   wxWidgets must be installed on your system.

                   Please check that wx-config is in path, the directory
                   where wxWidgets libraries are installed (returned by
                   'wx-config --libs' or 'wx-config --static --libs' command)
                   is in LD_LIBRARY_PATH or equivalent variable and
                   wxWidgets version is 2.8.4 or above.

   *********************************************************************
   **********************  APPLICATIONS INFORMATION  *******************
   *********************************************************************

   wx             : wxWidgets not found, wx will NOT be usable

   *********************************************************************

解决办法

::

   yum install https://mirrors.huaweicloud.com/epel/epel-release-latest-7.noarch.rpm
   rpm --import https://mirrors.huaweicloud.com/epel/RPM-GPG-KEY-EPEL-7
   yum install wxGTK-devel

问题6： 缺少 odbc
~~~~~~~~~~~~~~~~~

::

   *********************************************************************
   **********************  APPLICATIONS DISABLED  **********************
   *********************************************************************

   odbc           : ODBC library - link check failed

   *********************************************************************

解决办法：

::

   yum install unixODBC-devel.aarch64

问题7： 缺少 fop
~~~~~~~~~~~~~~~~

::

   *********************************************************************
   **********************  DOCUMENTATION INFORMATION  ******************
   *********************************************************************

   documentation  :
                    fop is missing.
                    Using fakefop to generate placeholder PDF files.

   *********************************************************************

解决办法：

::

   yum install fop-1.1-6.el7.noarch

问题8： 没有java开发环境
~~~~~~~~~~~~~~~~~~~~~~~~

::

   jinterface     : No Java compiler found

::

   sudo yum install java-11-openjdk-devel.aarch64

.. |image0| image:: ../images/emqx_success_on_taishan2280v2.PNG
.. |image1| image:: ../images/emqx_web_dashboard.PNG


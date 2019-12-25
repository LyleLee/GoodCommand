***************************
rpmbuild
***************************

编译rpm包，打包rpm包

.. code-block:: shell

    rpmbuild --rebuild httpd-2.4.6-90.el7.centos.src.rpm




问题： warning: user mockbuild does not exist
===============================================

.. code-block:: console

    [user1@centos ~]$ rpm -ivh kernel-4.18.0-80.7.2.el7.src.rpm
    Updating / installing...
       1:kernel-4.18.0-80.7.2.el7         ################################# [100%]
    warning: user mockbuild does not exist - using root
    warning: group mockbuild does not exist - using root
    warning: user mockbuild does not exist - using root
    warning: group mockbuild does not exist - using root

解决办法

::
    sudo useradd mockbuild


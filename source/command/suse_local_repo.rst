Suse配置本地软件源
===================

配置过程了redhat差不多。

::

   mount SLE-15-SP1-Packages-aarch64-Beta4-DVD1.iso ./sdk
   zypper ar ./sdk  local_repo

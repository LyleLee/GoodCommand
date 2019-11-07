在Redhat上编译安装内核
======================

Get source code
---------------

You Should be RedHat’s customer/partner to have source code access
right.

.. code:: shell-session

   wget URL

There will be kernel-alt-4.14.0-115.el7a.src.rpm at current dir when
download successfuly.

Extract archive
---------------

.. code:: shell-session

   rpm2cpio kernel-alt-4.14.0-115.el7a.src.rpm | cpio -idmv
   xz -d linux-4.14.0-115.el7a.tar.xz
   tar -xf linux-4.14.0-115.el7a.tar
   cd linux-4.14.0-115.el7a/

Apply patch
-----------

Since having bugs to fix, we need to make some changes base on RedHat’s
release. You may skip this step if you just want to build the kernel.
Assuming patches are at ``~/patch/`` Do following commands under
``linux-4.14.0-115.el7a/`` by order

.. code:: shell-session

   git apply ~/patch/0001-net-hns3-remove-hns3_fill_desc_tso.patch
   git apply ~/patch/0002-net-hns3-move-DMA-map-into-hns3_fill_desc.patch
   git apply ~/patch/0003-net-hns3-add-handling-for-big-TX-fragment.patch
   git apply ~/patch/0004-net-hns3-rename-hns_nic_dma_unmap.patch
   git apply ~/patch/0005-net-hns3-fix-for-multiple-unmapping-DMA-problem.patch
   git apply ~/patch/0006-net-hns3-Fix-for-packet-buffer-setting-bug.patch
   git apply ~/patch/0007-net-hns3-getting-tx-and-dv-buffer-size-through-firmw.patch
   git apply ~/patch/0008-net-hns3-aligning-buffer-size-in-SSU-to-256-bytes.patch
   git apply ~/patch/0009-net-hns3-fix-a-SSU-buffer-checking-bug.patch
   git apply ~/patch/0010-net-hns3-add-8-BD-limit-for-tx-flow.patch

Creat a .config file
--------------------

Assuming you are build the kernel for current ARM64 system already had
RedHat installed. Simply copy .config from ``/boot/config-xxx`` is ok.

.. code:: shell-session

   cp /boot/config-4.14.0-115.el7a.aarch64 ./.config

Set CONFIG_SYSTEM_TRUSTED_KEYS empty at .config

.. code:: config

   CONFIG_SYSTEM_TRUSTED_KEYS=""

Get build script to build kernel
--------------------------------

::

   wget https://raw.githubusercontent.com/xin3liang/home-bin/master/build-kernel-natively.sh

set rpm name as you like by assign a value to LOCALVERSION

::

   export LOCALVERSION="-liuxl-test-`date +%F`"

install dependence
------------------

::

   yum install -y ncurses-devel make gcc bc bison flexelfutils-libelf-devel openssl-devel

Run script
----------

.. code:: shell-session

   chmod +x build-kernel-natively.sh
   ./build-kernel-natively.sh

After script top, there will be two files at
``~/rpmbuild/RPMS/aarch64``,looks like:

.. code:: shell-session

   kernel-4.14.0_liuxl_test_2019_02_27-1.aarch64.rpm
   kernel-headers-4.14.0_liuxl_test_2019_02_27-1.aarch64.rpm

Install new kernel
------------------

.. code:: shell-session

   yum install kernel-4.14.0_liuxl_test_2019_02_27-1.aarch64.rpm

Reboot and choose the new kernel to start up

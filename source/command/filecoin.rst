********************************
filecoin
********************************

去中心化的存储网络


filecoin 目前没有ARM64版本。

.. code-block:: console

    [user1@centos filecoin]$ pwd
    /home/user1/open_software/filecoin-release/filecoin
    [user1@centos filecoin]$ file ./*
    ./go-filecoin: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=357de502b13f0450cbe7b1fc0ed73fadffe9e1f5, not stripped
    ./paramcache:  ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=1c5add2b39bb2cd4c383af6cbef91fe9c4495af3, not stripped


filecoin的编译需要下载很多go模块， 被屏蔽。

.. code-block:shell

    [user1@centos go-filecoin]$
    [user1@centos go-filecoin]$ FILECOIN_USE_PRECOMPILED_RUST_PROOFS=true go run ./b                                                                                                                      uild deps
    pkg-config --version
    0.27.1
    Installing dependencies...
    go mod download
     13.32 KiB / 13.32 KiB [===============================] 100.00% 100.43 KiB/s 0s
     147.90 MiB / 147.90 MiB [================================================================================================================================================] 100.00% 588.52 KiB/s 4m17s
     4.88 KiB / 4.88 KiB [========================================================================================================================================================] 100.00% 27.33 KiB/s 0s
     13.32 KiB / 13.32 KiB [======================================================================================================================================================] 100.00% 81.60 KiB/s 0s
     4.88 KiB / 4.88 KiB [========================================================================================================================================================] 100.00% 55.46 MiB/s 0s
     13.32 KiB / 13.32 KiB [=====================================================================================================================================================] 100.00% 378.19 KiB/s 0s
     2.04 GiB / 2.48 GiB [=======================================================================================================================>--------------------------]  82.07% 587.53 KiB/s 1h0m35s
     4.88 KiB / 4.88 KiB [========================================================================================================================================================] 100.00% 10.93 MiB/s 0s
     4.88 KiB / 4.88 KiB [========================================================================================================================================================] 100.00% 44.05 MiB/s 0s
     4.88 KiB / 4.88 KiB [===============================


执行成功出现：

.. code-block:: shell

                                     Dload  Upload   Total   Spent    Left  Speed
    100 9498k  100 9498k    0     0   548k      0  0:00:17  0:00:17 --:--:--  593k
    + [[ 0 -ne 0 ]]
    + eval 'tarball_path='\''/tmp/filecoin-ffi-Linux_16941733.tar.gz'\'''
    ++ tarball_path=/tmp/filecoin-ffi-Linux_16941733.tar.gz
    ++ mktemp -d
    + tmp_dir=/tmp/tmp.hWE9Bq7GHa
    + tar -C /tmp/tmp.hWE9Bq7GHa -xzf /tmp/filecoin-ffi-Linux_16941733.tar.gz
    + find -L /tmp/tmp.hWE9Bq7GHa -type f -name filecoin.h -exec cp -- '{}' . ';'
    + find -L /tmp/tmp.hWE9Bq7GHa -type f -name libfilecoin.a -exec cp -- '{}' . ';'
    + find -L /tmp/tmp.hWE9Bq7GHa -type f -name filecoin.pc -exec cp -- '{}' . ';'
    + echo 'successfully installed prebuilt libfilecoin'
    successfully installed prebuilt libfilecoin

问题记录
======================

缺少opencl
--------------

.. code-block:: console

    # github.com/filecoin-project/filecoin-ffi
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: cannot find -lOpenCL
    collect2: error: ld returned 1 exit status

解决办法

.. code-block:: shell

    sudo dnf install -y ocl-icd-devel.aarch64


输入文件是x86的
------------------

.. code-block:: console

    lecoin.a(futures_cpupool-1f3bf26aa9279af0.futures_cpupool.ahnnhqyk-cgu.3.rcgu.o)' is incompatible with aarch64 output
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: i386:x86-64 architecture of input file `/home/user1/open_software/gopath/src/github.com/filecoin-project/go-filecoin/vendors/filecoin-ffi/libfilecoin.a(futures_cpupool-1f3bf26aa9279af0.futures_cpupool.ahnnhqyk-cgu.4.rcgu.o)' is incompatible with aarch64 output
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: i386:x86-64 architecture of input file `/home/user1/open_software/gopath/src/github.com/filecoin-project/go-filecoin/vendors/filecoin-ffi/libfilecoin.a(qutex-8dfbe8197b98ccc5.qutex.8mzkyvtz-cgu.0.rcgu.o)' is incompatible with aarch64 output
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: i386:x86-64 architecture of input file `/home/user1/open_software/gopath/src/github.com/filecoin-project/go-filecoin/vendors/filecoin-ffi/libfilecoin.a(qutex-8dfbe8197b98ccc5.qutex.8mzkyvtz-cgu.1.rcgu.o)' is incompatible with aarch64 output
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: i386:x86-64 architecture of input file `/home/user1/open_software/gopath/src/github.com/filecoin-project/go-filecoin/vendors/filecoin-ffi/libfilecoin.a(blake2s_simd-e06fbb96181f173a.blake2s_simd.cqrh7vav-cgu.11.rcgu.o)' is incompatible with aarch64 output
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: i386:x86-64 architecture of input file `/home/user1/open_software/gopath/src/github.com/filecoin-project/go-filecoin/vendors/filecoin-ffi/libfilecoin.a(crossbeam_utils-e8dfdc01aecf4d4c.crossbeam_utils.av4hkwzx-cgu.0.rcgu.o)' is incompatible with aarch64 output
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: i386:x86-64 architecture of input file `/home/user1/open_software/gopath/src/github.com/filecoin-project/go-filecoin/vendors/filecoin-ffi/libfilecoin.a(blake2b_simd-8e21006b644a8dcd.blake2b_simd.du1wdeab-cgu.11.rcgu.o)' is incompatible with aarch64 o

未解决。可能是go编译工程没有成功
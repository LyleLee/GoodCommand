****************************
opencl
****************************

+ CPU: 鲲鹏920 ARM64 
+ OS: CentOS


编译工程的时候提示找不到lOpenCL的库

.. code-block:: console

    # github.com/filecoin-project/filecoin-ffi
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: cannot find -lOpenCL
    collect2: error: ld returned 1 exit status

解决办法

.. code-block:: shell

    sudo dnf install -y ocl-icd-devel.aarch64
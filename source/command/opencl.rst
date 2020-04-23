****************************
opencl
****************************

+ CPU: 鲲鹏920 ARM64


使用OpenCL一般包括：编写OpenCL应用程序，链接到OpenCL ICD loader，调用平台的OpenCL实现。


.. image:: https://raw.githubusercontent.com/bashbaug/OpenCLPapers/markdown/images/OpenCL-ICDs.png


目前Kunpeng上可用的组合是： **OpenCL ICD loader + POCL**

+ 在Ubuntu上验证通过

.. code-block:: console

    root@0598642de616:~# clinfo
    Number of platforms                               1
    Platform Name                                   Portable Computing Language
    Platform Vendor                                 The pocl project
    Platform Version                                OpenCL 1.2 pocl 1.1 None+Asserts, LLVM 6.0.0, SLEEF, POCL_DEBUG, FP16
    Platform Profile                                FULL_PROFILE
    Platform Extensions                             cl_khr_icd
    Platform Extensions function suffix             POCL

.. code-block:: console

    root@c698c179d2d2:~/opencl-book-samples/build/src/Chapter_2/HelloWorld# ./HelloWorld
    Could not create GPU context, trying CPU...
    0 3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87
    90 93 96 99 102 105 108 111 114 117 120 123 126 129 132 135 138 141 144 147 150 153
    156 159 162 165 168 171 174 177 180 183 186 189 192 195 198 201 204 207 210 213 216
    219 222 225 228 231 234 237 240 243 246 249 252 255 258 261 264 267 270 273 276 279

+ 在CentOS上未验证通过

.. [#opencl_icd] OpenCL ICD loader https://github.com/KhronosGroup/OpenCL-ICD-Loader
.. [#POCL] portable open source implementation of the OpenCL standard http://portablecl.org/

其他问题记录：

编译工程的时候提示找不到lOpenCL的库

.. code-block:: console

    # github.com/filecoin-project/filecoin-ffi
    /opt/rh/devtoolset-8/root/usr/libexec/gcc/aarch64-redhat-linux/8/ld: cannot find -lOpenCL
    collect2: error: ld returned 1 exit status

解决办法

.. code-block:: shell

    sudo dnf install -y ocl-icd-devel.aarch64


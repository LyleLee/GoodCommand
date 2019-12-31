*************************
modprobe
*************************

modprobe 用于加载内核模块和卸载内核模块

.. code-block:: shell

    modprobe hello
    modprobe -r hello

insmod可以加载任意路径的模块。 modprobe只会查找和加载标准安装目录下的模块，标准安装目录通常是 ``/lib/modules/(kernel version)/`` 。 modprobe会自动对要加载的模块查找依赖关系，如果还需要加载其它模块，那它会加载他们。而insmod会直接报错。
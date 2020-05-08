***********************
gdb
***********************


gdb 常用命令

在gdb中给python代码打断点[#python_gdb]_ 。handle_uncaught_exception

.. code-block:: gdb

    b PyEval_EvalFrameEx if strcmp(PyString_AsString(f->f_code->co_name), "handle_uncaught_exception") == 0


.. [#linuxtools] gdb 调试利器 https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/gdb.html
.. [#python_gdb] https://stripe.com/blog/exploring-python-using-gdb

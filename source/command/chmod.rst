*****************
chmod
*****************

文件权限操作

修改自己的文件权限
-------------------

.. code-block:: shell

    chmod -w myfile
    chmod -rwx file
    chmod +wx file
    chmod =r myfile


用户(u)，组(g)， 其它(o)
-------------------------

.. code-block:: shell

    chmod u=rw myfile
    chmod g=rw myfile
    chmod ug=rw myfile
    chmod o= myfile
    chmod o-rw myfile
    chmod g+r myfile
    chmod g-w myfile
sshfs
=====

使用ssh映射远程主机目录到当前主机

.. code:: \

   mkdir 201
   sshfs me@192.168.1.201:/home/me/syncfile 201
   fusermount -u 201

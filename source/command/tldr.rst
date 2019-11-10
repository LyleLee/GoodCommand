tldr
====

一个合理的解释是：\ **too long dont read**

查看man文档实在是太长了， 大家都很忙，
哪里有那么多时间看，即使看了，一个命令参数那么多，谁记得住。所以tldr是一个更加简单的、由社区驱动的
man pages。 用它可以直接查看命令的常用例子

.. code-block:: console

   me@ubuntu:~$ tldr scp
   scp
   Secure copy.
   Copy files between hosts using Secure Copy Protocol over SSH.

    - Copy a local file to a remote host:
      scp {{path/to/local_file}} {{remote_host}}:{{path/to/remote_file}}

    - Copy a file from a remote host to a local folder:
      scp {{remote_host}}:{{path/to/remote_file}} {{path/to/local_dir}}

    - Recursively copy the contents of a directory from a remote host to a local directory:
      scp -r {{remote_host}}:{{path/to/remote_dir}} {{path/to/local_dir}}

    - Copy a file between two remote hosts transferring through the local host:
      scp -3 {{host1}}:{{path/to/remote_file}} {{host2}}:{{path/to/remote_dir}}

    - Use a specific username when connecting to the remote host:
      scp {{path/to/local_file}} {{remote_username}}@{{remote_host}}:{{path/to/remote_dir}}

    - Use a specific ssh private key for authentication with the remote host:
      scp -i {{~/.ssh/private_key}} {{local_file}} {{remote_host}}:{{/path/remote_file}}

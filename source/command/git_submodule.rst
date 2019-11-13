******************
git submodule
******************
如果在一个git仓库中，想要包含另一个git仓库，这个时候有多种实现方式。 可以使用repo 或者 git 自带的submodule。 这里介绍一下submodule。

克隆一个带子模块的仓库，这个时候会把仓库下的所有子模块都下载下来

.. code-block:: bash

   git clone --recurse-submodules git@lixianfa.github.com:LyleLee/GoodCommand.git

也可以切换到工程之后使用命令更新

.. code-block:: bash

   git submodule update

添加一个子工程

.. code-block:: bash

   git submodule add git@github.com:LyleLee/arm_neon_example.git source/src/arm_neon_example

.. code-block:: console
 
   [user1@centos GoodCommand]$ git submodule add git@github.com:LyleLee/arm_neon_example.git source/src/arm_neon_example
   Cloning into 'source/src/arm_neon_example'...
   Enter passphrase for key '/home/user1/.ssh/id_rsa':
   remote: Enumerating objects: 5, done.
   remote: Counting objects: 100% (5/5), done.
   remote: Compressing objects: 100% (5/5), done.
   remote: Total 5 (delta 0), reused 0 (delta 0), pack-reused 0
   Receiving objects: 100% (5/5), 1.64 KiB | 0 bytes/s, done.

修改已经设置好的子模块的git url。

.. code-block:: bash

   git config --file=.gitmodules submodule.Submod.url git@lixianfa.github.com:LyleLee/arm_neon_example.git
   git submodule sync


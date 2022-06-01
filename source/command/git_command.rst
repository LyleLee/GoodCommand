============
git command
============

::

   git clone  ssh://[user@]host.xz[:port]/path/to/repo.git/
   git config --global color.ui true   #有时候git没有颜色，可以这么设置

文件操作
--------

.. code::

   rm readme.md           #删除文件， 但是文件还保存在暂存区
   git rm readme.md       #从暂存区删除文件，以后不再追踪，从工作目录删除文件
   git rm --cached README #从暂存区删除文件，但是仍然保留在工作区
   git rm log/\*.log      #删除log目录下的所有.log文件，由于git有自己的展开，所以不需要shell进行展开
   git clean -f           # 删除 untracked files
   git clean -fd          # 连 untracked 的目录也一起删掉
   git clean -xfd         # 连 gitignore 的untrack 文件/目录也一起删掉 （慎用，一般这个是用来删掉编译出来的 .o之类的文件用的）
   git archive --format=zip --output ../kernel-alt-4.14.0-115.6.1.el7a.zip kernel-alt-4.14.0-115.6.1.el7a  #打包代码
   # 在用上述 git clean 前，墙裂建议加上 -n 参数来先看看会删掉哪些文件，防止重要文件被误删
   git clean -nxfd
   git clean -nf
   git clean -nfd

提交和历史
----------

.. code-block:: shell

   git log                                 #当前分支的提交历史
   git log --oneline                       #单行显示log
   git log --oneline --graph               #图形显示提交历史
   git log --pretty=oneline pb/master      #远程仓库pb下的master提交历史
   git log nfs-revert-and-hang             #查看某分支nfs-revert-and-hang的log
   git log --name-only                     #仅仅显示修改的文件
   git log --name-status                   #仅仅显示修改的文件，和文件状态
   git log --oneline --decorate            #显示HEAD指针和分支指向的提交对象
   git log --oneline master..origin/master #显示本地master和远程仓库的commit差异, 只显示远程仓库有，而本地master没有的部分
   git log --oneline master...origin/master #显示，除了两个分支都有的部分之外的差异。 远程仓库有本地没有 + 远程仓库没有本地有
   git log --oneline --decorate --left-right --graph master...origin/master #带<表示属于master， 带>表示属于远程仓库

   git tag --contains <commit>             #查看包含commit的tag
   git log -p -2                           #展开显示每次提交差异， -2 只显示最近两次更新git
   git reset HEAD CONTRIBUTING.md          #从暂存区测出被误staged的文件
   git reset HEAD^                         #回退最近一次提交, 这个提交的修改会保留，git status 显示待添加
   git reset --hard HEAD^                  #回退最近一次提交，这个提交不会被保留， git status 显示clean

你提交后发现忘记了暂存某些需要的修改，可以像下面这样操作。最后，提交只有一个。

::

   git commit -m 'initial commit'
   git add forgotten_file
   git commit --amend
   git add *

远程仓库远程
----------------

::

   git remote -v                                        #显示远程仓库
   git remote show origin                               #显示远程仓库详细信息
   git ls-remote                                        #查看远程库更多信息
   git push origin master                               #推送本地master分支到远程仓库origin

   git tag                                              #显示标签
   git tag -l 'v1.8.5*'                                 #显示某个标签详细信息

   git remote add pb https://github.com/paulboone/ticgit #添加远程仓库
   git remote rename pb paul                            #重命名远程仓库

   git log --oneline origin/master..master              #查看本地master比远程仓库多多少个commit
   一般情况下


PR 拉取与测试
------------------

::

   git fetch origin pull/124/head:fauxrep2

只需要跟还数字124和分支名fauxrep2即可

分支创建管理
------------

::

   git branch -a                                       #显示多有本地和远程分支
   git checkout -b iss53                               #创建分支并切换
   git branch iss53
   git checkout iss53
   git branch -r                                       #查看所有远程分支，所有分支
   git branch -a
   git branch -d hotfix                                #删本地分支
   git push origin --delete me-linux-comments          #删除远程仓库origin的me-linux-comments分支
   git branch -m oldname newname                       #重命名分支
   git ls-tree -r master --name-only                   #查看分支已经tracked的file
   git push origin serverfix:awesomebranch             #推送本地serverfix分支到远程仓库上的awesomebranch
   git push origin serverfix:serverfix                 #推送本地的serverfix分支到远程的serverfix分支
   git checkout -b serverfix origin/serverfix          #创建并切换到跟踪远程分支的本地分支serverfix
   git checkout -b sf origin/serverfix                 #创建并切换到跟踪远程分支的本地分支sf
   git checkout --track origin/serverfix               #自动切换到跟踪远程分支的本地分支
   git checkout --patch master include/uapi/linux/mii.h#把master分支的指定文件合并到当前分支

生成patch与合入patch
--------------------

| **diff 和 patch 命令组合**
| 使用diff比较文件差异并生成patch文件，
  然后使用patch合入修订，适用于没有版本管理的场景
  例子请查看\ `[diff] <diff.md>`__

| **git diff 和 git apply 组合**
| 使用git diff 成patch， 使用git apply 命令合入代码。 git apply
  可以加参数–check，可以更加安全的合入和撤销代码

::

   git diff > add_function.patch                 #当前仓库中修改，但是未暂存的文件生成patch
   git diff --cached > add_function.patch        #当前仓库已经暂存，但是没提交的文件生成patch
   git diff --staged --binary > mypatch.patch    #二进制文件patch
   git diff --relative 1bc4aa..1c7b4e            #以相对当前路径，生成两个commit之间的patch，适合用于生成模块的patch


   git apply add_function.patch                  #git apply 可以保证一个patch可以完整合入或者完全不合入
   git apply -p0 add_function                    #如果需要去除前缀路径

| **git format-patch和git am组合**
| git format-patch可以针对git仓库的commit和版本生成patch，使用git am
  可以完整合入patch中的commit信息,也就是作者和message等。前面的patch版本管理方式都是只针对代码改动，不包含提交的commit信息。

::

   git format-patch master                                 #在当前分支,生成master到当前分支的patch，一个commit一个patch。默认当前分支是从参数中的分支（master）分出来的
   git format-patch master --stdout > add_function.patch   #生成单个文件的patch
   git format-patch -s fe21342443 -o today/                #生成自从fe21342443以来的patch，每个comit一个patch

   git am add_function.patch                                #以提交方式合入patch
   git apply add_function.patch                            #以修改，未暂存方式合入patch

如果错误向github提交了敏感信息如密码：
--------------------------------------

包含敏感信息的文件为server_start_up_log.txt

::

   git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch docs/resources/server_start_up_log.txt' --prune-empty --tag-name-filter cat -- --all
   git push origin master --force

use git over a SSH proxy
---------------------------

::

   ssh -f -N -D 127.0.0.1:3128 xxx@xx.x.xx.xx

   git config --global http.proxy 'socks5://127.0.0.1:3128'
   git config --global https.proxy 'socks5://127.0.0.1:3128'

use git over socks5 proxy
--------------------------

如果使用window git bash, 在`~/.ssh/config`中：

::

   Host github.com
      User git
      ProxyCommand connect -S localhost:xxxx %h %p


https://gist.github.com/coin8086/7228b177221f6db913933021ac33bb92#:~:text=SSH%20Protocol&text=This%20is%20to%20make%20all,the%20proxy%20at%20localhost%3A1080%20.&text=This%20uses%20a%20proxy%20only,nc%20and%20ssh%20config%20ProxyCommand%20.

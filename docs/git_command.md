git 常用命令

## 文件操作

```log
rm readme.md            #删除文件， 但是文件还保存在暂存区
git rm readme.md        #从暂存区删除文件，以后不再追踪，从工作目录删除文件
git rm --cached README  #从暂存区删除文件，但是仍然保留在工作区
git rm log/\*.log       #删除log目录下的所有.log文件，由于git有自己的展开，所以不需要shell进行展开
git archive --format=zip --output ../kernel-alt-4.14.0-115.6.1.el7a.zip kernel-alt-4.14.0-115.6.1.el7a  #打包代码
```

## 提交和历史
显示提交信息
```
git log                             #当前分支的提交历史
git log --pretty=oneline --graph    #图形显示提交历史
git log --pretty=oneline pb/master  #远程仓库pb下的master提交历史
git log nfs-revert-and-hang         #查看某分支nfs-revert-and-hang的log
git log --name-only                 #仅仅显示修改的文件
git log --name-status               #仅仅显示修改的文件，和文件状态
```
显示HEAD指针和分支指向的提交对象
```
git log --oneline --decorate	 
```
你提交后发现忘记了暂存某些需要的修改，可以像下面这样操作。最后，提交只有一个。
```
git commit -m 'initial commit' 
git add forgotten_file 
git commit --amend	
git add * 
```
从暂存区测出被误staged的文件
```
git reset HEAD CONTRIBUTING.md	
```
展开显示每次提交差异， -2 只显示最近两次更新git	
```
git log -p -2
```

## 远程仓库远程分支
显示远程仓库
```
git remote -v 
git remote show origin	
```
推送本地master分支到远程仓库origin
```
git push origin master
```
显示标签	
```
git tag 
git tag -l 'v1.8.5*'	 
```
添加远程仓库
```
git remote add pb https://github.com/paulboone/ticgit
```
查看远程仓库	
```
git remote show origin	
```
重命名远程仓库
```
git remote rename pb paul	
```
查看远程库更多信息
```
git ls-remote	
```
## 分支创建管理
创建分支并切换
```
git checkout -b iss53 or: 
git branch iss53 
git checkout iss53	
```
查看所有远程分支，所有分支
```
git branch -r
git branch -a
```
删除分支
```
git branch -d hotfix	
```
查看分支已经tracked的file
```
git ls-tree -r master --name-only	
```

推送本地serverfix分支到远程仓库上的awesomebranch
```
git push origin serverfix:awesomebranch 
```
推送本地的serverfix分支到远程的serverfix分支
```
git push origin serverfix:serverfix	
```
创建并切换到跟踪远程分支的本地分支serverfix
```
git checkout -b serverfix origin/serverfix
```
创建并切换到跟踪远程分支的本地分支sf	
```
git checkout -b sf origin/serverfix	
```
自动切换到跟踪远程分支的本地分支
```
git checkout --track origin/serverfix
```

```
git checkout --patch master include/uapi/linux/mii.h    #把master分支的指定文件合并到当前分支
```
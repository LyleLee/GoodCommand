git 常用命令

## 文件操作

删除文件， 但是文件还保存在暂存区\
```
rm readme.md	
```
从暂存区删除文件，以后不再追踪，从工作目录删除文件 
```
git rm readme.md 
```
从暂存区删除文件，但是仍然保留在工作区
```
git rm --cached README	
```
删除log目录下的所有.log文件，由于git有自己的展开，所以不需要shell进行展开
```
git rm log/\*.log	
```

## 提交和历史
显示提交信息
```
git log --pretty=oneline --graph
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
git log -p -2	-p 
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
重命名远程分支
```
git remote rename pb paul	
```
查看远程分支的更多信息
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
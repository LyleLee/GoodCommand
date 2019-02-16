一台电脑两个github账号设置
=================

账户信息配置,取消全局账户

```git
#查看配置信息
git config -l

#如果配置有全局账户，建议取消全局账户，因为我们需要每个不同的仓库使用自己的账户提交代码
git config --global --unset user.name
git config --global --unset user.email
```
如果想重新配置全局账户
```git
git config --global user.name "zhangshan@gmail.com"
git config --global user.email "zhangshan"
```

假设这两个账号分别是

+ tom one@gmail.com
+ sam @gmail.com

## SSH的配置
配置ssh的目的是，每次提交代码的时候不需要使用https的方式每次都输入账户和密码。  
我们需要分别产生这两个账号的公钥添加的github settting下面的 `SSH and GPG keys`下的SSH keys当中

查看是否有之前的公钥，并删除，否则git会自己选择默认公钥进行链接
```git
ls ~/.ssh/
rm id_rsa_*
```
查看之前添加公钥
```git
ssh-add -l
```
如果执行不成功
```
$ ssh-add -l
Could not open a connection to your authentication agent.
```
需要执行
```git
eval `ssh-agent -s`
```
生成私钥公钥对
```shell-scripts
ssh-keygen -t rsa -C "one@gmail.com" -f ~/.ssh/id_rsa_one
ssh-keygen -t rsa -C "two@gmail.com" -f ~/.ssh/id_rsa_two
```
这个时候会得到文件
```shell-scripts
-rw-r--r-- 1 Administrator 197121 1831 2月  12 17:36 id_rsa_one
-rw-r--r-- 1 Administrator 197121  405 2月  12 17:36 id_rsa_one.pub
-rw-r--r-- 1 Administrator 197121 1831 2月  12 19:09 id_rsa_two
-rw-r--r-- 1 Administrator 197121  409 2月  12 19:09 id_rsa_two.pub
```
把id_rsa_one.pub和id_rsa_two.pub的内容添加到github账户的ssh-keys当中
```shell-session
cat id_rsa_one.pub
#复制内容,在浏览器中添加到github账户的ssh-keys当中
```
编辑`~/.ssh/config`文件,其中的Host是可以指定的，后面远程仓库的url需要和它一致
```config
#one
Host one.github.com
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa_one

#two
Host two.github.com
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa_two
```
测试ssh是否成功
```shell-session
ssh -T git@one.github.com
ssh -T git@two.github.com
#如果没有添加公钥.pub到文件到相应的github账户会出现
Permission denied (publickey).
#如果已经添加公钥,会提示成功
Hi tom! You've successfully authenticated, but GitHub does not provide shell access.
```

教程提到每次重启都要执行：
```console
ssh-add ~/.ssh/id_rsa_one
ssh-add ~/.ssh/id_rsa_two
```
可以使用-k避免每次重启都要执行添加动作
```
ssh-add -k ~/.ssh/id_rsa_one
ssh-add -k ~/.ssh/id_rsa_two
```

## 仓库配置
到每个仓库与下设置user.name 和 user.email
```git
#仓库1
git config user.name "tom"
git config user.email "one@gmail.com" 
#仓库2
git config user.name "sam"
git config user.email "two@gmail.com" 
```
到每个仓库下修改，修改远程仓库地址，如果不修改，提交将不成功
```git
#查看旧值
git config -l
remote.origin.url=git@two.github.com:LyleLee/GoodCommand.git
#设置新值
git config remote.origin.url "git@two.github.com:LyleLee/GoodCommand.git"
```
这个时候查看远程仓库的信息,可以看到已经修改好。
```git
git remote -v
origin  git@two.github.com:LyleLee/GoodCommand.git (fetch)
origin  git@two.github.com:LyleLee/GoodCommand.git (push)
```
这个时候git push origin 就可以了

参考配置教程  
[http://summertreee.github.io/blog/2017/10/16/yi-tai-dian-nao-she-zhi-duo-ge-githubzhang-hao/](http://summertreee.github.io/blog/2017/10/16/yi-tai-dian-nao-she-zhi-duo-ge-githubzhang-hao/)

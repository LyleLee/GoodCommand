vim
==========
编辑工具常用功能

```
:f		#显示当前文件路径
:set number		#显示行号
:set ff=unix    #更改文件为unix格式
:set invlist    #显示所有不可见字符，set invlist可以关闭 另外cat -A file也可以看到
:wq
:s/vivian/sky/ 	#替换当前行第一个 vivian 为 sky
:s/vivian/sky/g #替换当前行所有 vivian 为 sky
:noh
:y10            #复制以下十行
:10y            #复制第10行
:p              #黏贴复制内容
:10dd           #剪切10行

:[range]s/源字符串/目标字符串/[option]   #替换命令
:%s/ListNode/ConstructNode/gc            #ListNode→ConstructNode
:s/line/lines/g                          #表示将光标所在当前行的line全局替换为lines
:2,3s/line/lines/g                       #表示将2~3行的line全局替换为lines
:%s= *$==                                #表示全局替换行尾的一个或多个空格

shift+*			#搜索当前光标所在单词
```



# 参考文档

[https://vimjc.com/vim-substitute.html](https://vimjc.com/vim-substitute.html)
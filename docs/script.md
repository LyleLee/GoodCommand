script 保存终端产生的log
===============
平时执行命令，希望保留命令以及命令的执行结果为log，复制粘贴的手工方式太繁琐了， 是时候自动记录log了


执行命令后会重新会到命令行，但是之后的输出会保存到typescript当中
```
script
```
也可以手动指定文件
```
script -f program_all.log
```
退出script。推出shell的时候script的记录会自动结束
```
ctrl+d
exit
```

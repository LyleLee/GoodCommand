***********************
pandoc 
***********************

下载地址

https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-windows-x86_64.msi

::

   pandoc --from markdown --to rst
   
   # 在docker中运行，转换html到rst文档
   docker run --rm -v "$(pwd):/data" pandoc/core -f html -t rst -o /data/eipa.rst /data/eipa.html
   

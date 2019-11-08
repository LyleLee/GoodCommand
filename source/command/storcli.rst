storcli64
=========

OS内划分raid

storcli64用法：

::

   查看所有FW信息：storcli64 /c0 show all 
   查看 storcli64.exe /c0 show
   创建raid1: storcli64.exe /c0 add vd r1 drives=33:0-1
   创建raid10: storcli64 /c0 add vd type=raid10 size=2gb,3gb,4gb names=tmp1,tmp2,tmp3 drives=252:2-3,5,7 padperarray=2(参考)
   storcli64 /c0 add vd r10 drives=0,1,2,3 pdperarray=2
   storcli64 /c1 add vd r1 size=30GB drives=2,3

   删除  storcli64.exe /c0/vall del 

   对VD*完全初始化  storcli64 /c0/v* start init full
   对VD*快速初始化  storcli64 /c0/v* start init force
   查询初始化进度   storcli64 /c0/vall show init

   关闭硬盘cache    storcli64 /c0/vall set pdcache=off

   查看误码：storcli64 /c0/pall show all

   清除误码
   echo -e "\n8\n2\n10\n1\nPHYID\n05\n7\n0\n11\n08\n0\n0\n" | storelibtest -expert

   for((i=0;i<=23;i++)); do echo -e "\n8\n2\n10\n1\n$i\n05\n7\n0\n11\n08\n0\n0\n" | storelibtest -expert; done
   清除0-23 phy误码，23可以根据需要设置

   stoponerror

ceph erasure-code 纠删码 插件确认
=================================

问下客户，EC X86有没有用ISA-L 库，还是默认的Jerasure。
使用的纠删码不一样会导致测试结果不一样

::

   [root@ceph-node00 ~]# ceph osd erasure-code-profile get default
   k=2
   m=1
   plugin=jerasure
   technique=reed_sol_van
   [root@ceph-node00 ~]# ceph osd erasure-code-profile get testprofile
   crush-device-class=
   crush-failure-domain=host
   crush-root=default
   jerasure-per-chunk-alignment=false
   k=5
   m=3
   plugin=jerasure
   technique=reed_sol_van
   w=8
   [root@ceph-node00 ~]#

使用的是jerasure

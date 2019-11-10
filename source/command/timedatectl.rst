*********************************
timedatectl tzselect 
*********************************

ubuntu tzselect设置过程
============================

| 选择系统所在时区。
| 有时候服务器在全球各地，虽然安装地点不一样，时区已经自动设置好，但是希望显示的时候按照亚洲时区来显示，好知道什么时间发生了什么事。
| 查看系统时间，发现是西5区

::

   root@ubuntu:~# date -R
   Wed, 13 Feb 2019 03:42:38 -0500

::

   root@ubuntu:~# tzselect
   Please identify a location so that time zone rules can be set correctly.
   Please select a continent, ocean, "coord", or "TZ".
    1) Africa
    2) Americas
    3) Antarctica
    4) Asia
    5) Atlantic Ocean
    6) Australia
    7) Europe
    8) Indian Ocean
    9) Pacific Ocean
   10) coord - I want to use geographical coordinates.
   11) TZ - I want to specify the time zone using the Posix TZ format.
   #? 4
   Please select a country whose clocks agree with yours.
    1) Afghanistan           18) Israel                35) Palestine
    2) Armenia               19) Japan                 36) Philippines
    3) Azerbaijan            20) Jordan                37) Qatar
    4) Bahrain               21) Kazakhstan            38) Russia
    5) Bangladesh            22) Korea (North)         39) Saudi Arabia
    6) Bhutan                23) Korea (South)         40) Singapore
    7) Brunei                24) Kuwait                41) Sri Lanka
    8) Cambodia              25) Kyrgyzstan            42) Syria
    9) China                 26) Laos                  43) Taiwan
   10) Cyprus                27) Lebanon               44) Tajikistan
   11) East Timor            28) Macau                 45) Thailand
   12) Georgia               29) Malaysia              46) Turkmenistan
   13) Hong Kong             30) Mongolia              47) United Arab Emirates
   14) India                 31) Myanmar (Burma)       48) Uzbekistan
   15) Indonesia             32) Nepal                 49) Vietnam
   16) Iran                  33) Oman                  50) Yemen
   17) Iraq                  34) Pakistan
   #? 13

   The following information has been given:

           Hong Kong

   Therefore TZ='Asia/Hong_Kong' will be used.
   Selected time is now:   Wed Feb 13 16:47:13 HKT 2019.
   Universal Time is now:  Wed Feb 13 08:47:13 UTC 2019.
   Is the above information OK?
   1) Yes
   2) No
   #? 1

   You can make this change permanent for yourself by appending the line
           TZ='Asia/Hong_Kong'; export TZ
   to the file '.profile' in your home directory; then log out and log in again.

   Here is that TZ value again, this time on standard output so that you
   can use the /usr/bin/tzselect command in shell scripts:
   Asia/Hong_Kong

| 并没有起效果，系统提示，要想永久修改，在~/.profile后面追加一行
| ``TZ='Asia/Hong_Kong'; export TZ``
| 追加之后，退出重新登录

::

   root@ubuntu:~# date -R
   Wed, 13 Feb 2019 16:52:00 +0800
   root@ubuntu:~#

发现已经变成了东8区

RedHat timedatectl 设置过程
---------------------------

选择时区：
参考\ `[官方手册] <https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/chap-configuring_the_date_and_time>`__

.. code:: shell

   timedatectl list-timezones
   set-timezone Asia/Shanghai

   #redhat 8.0 chrony作为NTP客户端使用如下命令查看ntp同步状态
   systemctl status chronyd    #查看服务
   systemctl enable chronyd    #开机启动
   systemctl start chronyd     #启动服务
   chronyc sourcestats     #查看同步状态

::

   [root@localhost linux]# timedatectl
         Local time: Thu 2019-04-11 16:33:46 CST
     Universal time: Thu 2019-04-11 08:33:46 UTC
           RTC time: Thu 2019-04-11 08:33:47
          Time zone: Asia/Shanghai (CST, +0800)
        NTP enabled: yes
   NTP synchronized: yes
    RTC in local TZ: no
         DST active: n/a
   [root@localhost linux]#

RTC时间写如后，可以保证/var/log/message和/var/log/dmesg的时间在每次重启后对的。

local时间写入RTC

::

   timedatectl set-local-rtc 1

参考教程
https://www.maketecheasier.com/timedatectl-control-system-time-date-linux/

输出时间date
============

::

   [root@root ~]# date "+%Y-%m-%d"
   2013-02-19
   [root@root ~]# date "+%H:%M:%S"
   13:13:59
   [root@root ~]# date "+%Y-%m-%d %H:%M:%S"
   2013-02-19 13:14:19
   [root@root ~]# date "+%Y_%m_%d %H:%M:%S"  
   2013_02_19 13:14:58
   [root@root ~]# date -d today 
   Tue Feb 19 13:10:38 CST 2013
   [root@root ~]# date -d now
   Tue Feb 19 13:10:43 CST 2013
   [root@root ~]# date -d tomorrow
   Wed Feb 20 13:11:06 CST 2013
   [root@root ~]# date -d yesterday
   Mon Feb 18 13:11:58 CST 2013


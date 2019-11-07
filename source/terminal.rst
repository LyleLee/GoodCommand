无线网络
--------

扫描网络

.. code:: shell-session

   iwlist scan

指定wlan接口扫描

.. code:: shell-session

   iwlist wlan0 scanning

过滤显示SSID

.. code:: shell-session

   iwlist scan | grep ESSID

注意扫描太频繁可能不成功，原因不明，有可能是wlan标准规定。

::

   pi@raspberrypi:~ $ iwlist wlan0 scan | grep ESSID
                       ESSID:"hzh_zfj"
                       ESSID:"ChinaNet-pFRh"
                       ESSID:"303"
                       ESSID:"TP-LINK_9A09"
                       ESSID:"Xiaomi_DEA2"
                       ESSID:""
                       ESSID:"ChinaNet-4r5y"
                       ESSID:"Tamgm"
                       ESSID:"TP-LINK_FA7F"
                       ESSID:"809"
                       ESSID:"Xiaoxiaobai02"
   pi@raspberrypi:~ $

连接到网路
----------

.. code:: shell-session

    wpa_passphrase <SSID> [密码]

参考教程
--------

` <http://www.shumeipaiba.com/wanpai/jiaocheng/25.html>`__

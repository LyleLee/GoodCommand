*********************
bitcoin on arm
*********************

在ARM上区块链 [#bitcoin_project]_ 的支持情况如何，能否使用比特币。


有钱包即可使用比特币
==================================

目前钱包应用很多，有手机版，桌面版，专用硬件版，网页版[#bitcoin_client]_ 。可以根据情况到官网网址进行选择。

这里主要看下桌面版能否支持ARM，在上面的网址下载的安装包是bitcoin-0.19.0.1-arm-linux-gnueabihf.tar.gz。查看里面的二进制文件目前不支持ARM64的。

.. code-block: console

    [user1@centos bin]$ file bitcoind
    bitcoind: ELF 32-bit LSB shared object, ARM, version 1 (GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux 3.2.0, BuildID[sha1]=898fff0cd7312aa245c99b1a61b288315c92e693, stripped
    [user1@centos bin]$

不过我们在 bitcoin-core的网站上找到了ARM64版本bitcoin-0.19.0.1-aarch64-linux-gnu.tar.gz [#bitcoin_arm64]_

完整的钱包节点， 会下载所有的区块

.. code-block:: console

    wget https://bitcoincore.org/bin/bitcoin-core-0.19.0.1/bitcoin-0.19.0.1-aarch64-linux-gnu.tar.gz
    tar xf bitcoin-0.19.0.1-aarch64-linux-gnu.tar.gz
    cd bitcoin-0.19.0.1/bin
    ./btcoind

    2020-01-14T07:48:47Z UpdateTip: new best=00000000000000b13a8a169ef1a1250863c51839ecb72d465d36604c885b9ae8 height=199421 version=0x00000001 log2_work=68.720938 tx=7203671 date='2012-09-18T18:38:26Z' progress=0.014558 cache=349.9MiB(2601800txo)
    2020-01-14T07:48:47Z UpdateTip: new best=00000000000004b2fcafa911440c1316d39845266e6d92419e8c974133d5cb0c height=199422 version=0x00000001 log2_work=68.720973 tx=7203691 date='2012-09-18T18:48:39Z' progress=0.014558 cache=349.9MiB(2601796txo)
    2020-01-14T07:48:47Z UpdateTip: new best=0000000000000352997b2b2d470229ec466a29840c66db0bcfe22d00a9a3ba37 height=199423 version=0x00000001 log2_work=68.721007 tx=7203853 date='2012-09-18T18:48:00Z' progress=0.014558 cache=349.9MiB(2601638txo)
    2020-01-14T07:48:47Z UpdateTip: new best=000000000000021044e6f434018d66fda995c7827b06097fa87cac71ed14a1ee height=199424 version=0x00000001 log2_work=68.721041 tx=7204193 date='2012-09-18T19:05:10Z' progress=0.014559 cache=349.9MiB(2601851txo)
    2020-01-14T07:48:47Z UpdateTip: new best=000000000000014aeff9663da57c8bcc8a42fc9ad9b9fc33e0d249138f5bdfad height=199425 version=0x00000002 log2_work=68.721075 tx=7204705 date='2012-09-18T19:28:45Z' progress=0.014560 cache=349.9MiB(2601821txo)

同步数据可能需要很长时间，少则一两个小时，多则10多个小时，取决于和服务器的链接速度。

获取钱包信息：

.. code-block:: console

    [user1@centos bin]$ ./bitcoin-cli getwalletinfo
    {
      "walletname": "",
      "walletversion": 169900,
      "balance": 0.00000000,
      "unconfirmed_balance": 0.00000000,
      "immature_balance": 0.00000000,
      "txcount": 0,
      "keypoololdest": 1578981187,
      "keypoolsize": 1000,
      "keypoolsize_hd_internal": 1000,
      "paytxfee": 0.00000000,
      "hdseedid": "3a0f7a2e3ba2e1d4810db537959421be866c1f6c",
      "private_keys_enabled": true,
      "avoid_reuse": false,
      "scanning": false
    }


常用命令
================================

1. bitcoin-cli

.. code-block:: shell

    bitcoin-cli getwalletinfo       # 获取钱包信息
    bitcoin-cli getnetworkinfo      # 查看网络状态：
    bitcoin-cli getpeerinfo         # 查看网络节点：
    bitcoin-cli getblockchaininfo   # 查看区块链信息：如同步进度、
    bitcoin-cli help                # 查看所有命令

2. bitcoind

.. code-block:: shell

    ./bitcoind                      # 启动比特币服务
    ./bitcoind -c                   # 以配置文件启动后台服务

搭建运行自定义区块链服务
=================================

todo。。。。。



.. [#bitcoin_project] https://github.com/bitcoin/bitcoin
.. [#bitcoin_client] https://bitcoin.org/zh_CN/choose-your-wallet?step=5&platform=linux
.. [#bitcoin_arm64] https://bitcoincore.org/bin/bitcoin-core-0.19.0.1/


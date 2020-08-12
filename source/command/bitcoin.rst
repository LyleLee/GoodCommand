*********************
bitcoin
*********************

在ARM上区块链 [#bitcoin_project]_ 的支持情况如何，能否使用比特币。


有钱包即可使用比特币
==================================

目前钱包应用很多，有手机版，桌面版，专用硬件版，网页版 [#bitcoin_client]_ 。可以根据情况到官网网址进行选择。

这里主要看下桌面版能否支持ARM，在上面的网址下载的安装包是bitcoin-0.19.0.1-arm-linux-gnueabihf.tar.gz。查看里面的二进制文件目前不支持ARM64的。

.. code-block: console

    [user1@centos bin]$ file bitcoind
    bitcoind: ELF 32-bit LSB shared object, ARM, version 1 (GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux 3.2.0, BuildID[sha1]=898fff0cd7312aa245c99b1a61b288315c92e693, stripped
    [user1@centos bin]$

不过我们在 bitcoin-core的网站上找到了ARM64版本bitcoin-0.19.0.1-aarch64-linux-gnu.tar.gz [#bitcoin_arm64]_


下载比特币软件。

.. code-block:: console

    wget https://bitcoincore.org/bin/bitcoin-core-0.19.0.1/bitcoin-0.19.0.1-aarch64-linux-gnu.tar.gz
    tar xf bitcoin-0.19.0.1-aarch64-linux-gnu.tar.gz
    cd bitcoin-0.19.0.1/bin

启动服务，会自动同步区块 ::

   ./btcoind

    2020-07-16T01:53:17Z dnsseed thread exit
    2020-07-16T01:53:19Z Synchronizing blockheaders, height: 4000 (~0.66%)
    2020-07-16T01:53:21Z New outbound peer connected: version: 70015, blocks=639437, peer=5 (full-relay)
    2020-07-16T01:53:22Z New outbound peer connected: version: 70015, blocks=639437, peer=6 (full-relay)
    2020-07-16T01:53:23Z New outbound peer connected: version: 70015, blocks=639437, peer=7 (full-relay)
    2020-07-16T01:53:25Z New outbound peer connected: version: 70015, blocks=639437, peer=8 (full-relay)
    2020-07-16T01:53:33Z Synchronizing blockheaders, height: 6000 (~0.99%)
    2020-07-16T01:53:37Z Synchronizing blockheaders, height: 8000 (~1.33%)
    2020-07-16T01:53:43Z Synchronizing blockheaders, height: 10000 (~1.66%)
    2020-07-16T01:53:50Z Synchronizing blockheaders, height: 12000 (~1.99%)
    2020-07-16T01:53:53Z Synchronizing blockheaders, height: 14000 (~2.33%)
    2020-07-16T01:53:57Z Synchronizing blockheaders, height: 16000 (~2.66%)
    2020-07-16T01:54:06Z Synchronizing blockheaders, height: 18000 (~3.00%)
    2020-07-16T01:54:14Z Synchronizing blockheaders, height: 20000 (~3.35%)

同步数据可能需要很长时间，少则一两个小时，多则10多个小时，取决于和服务器的链接速度。

获取钱包地址: 3a0f7a2e3ba2e1d4810db537959421be866c1f6c :：

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

再创建一个钱包 ::

    root@40ab90fdd8df:~/bitcoin-0.19.0.1/bin# ./bitcoin-cli createwallet redwallet
    {
    "name": "redwallet",
    "warning": ""
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

区块链可以取消中间人，可以实现peer-to-peer的交易。

主要在金融领域应用和论证。全球范围内超过 90%
的中央银行已经开始了这方面的论证



.. [#bitcoin_project] https://github.com/bitcoin/bitcoin
.. [#bitcoin_client] https://bitcoin.org/zh_CN/choose-your-wallet?step=5&platform=linux
.. [#bitcoin_arm64] https://bitcoincore.org/bin/bitcoin-core-0.19.0.1/


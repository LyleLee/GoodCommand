******************************
blockchain
******************************

区块链


热门的区块链技术
=====================

1. bitcoin(数字货币) [#bitcoin]_

    这是最早也是最有名的区块链实施项目。一种可保存在电子钱包中的数字货币。

2. Ripple(区块链技术平台)

    Ripple 能提供全天候、实时、同步、透明且信息丰富的交易。在交易开始前，您能够实时确认汇率和费用，立即完成付款。 Ripple 解决方案为 MasterCard 和 Visa 等发卡机构整合了付款消息传递和资金结算功能


3. Ethereum(数字货币)
    扩展比特币平台，让比特币能处理数字货币以外的普通交易。为了做到这一点，他们需要一个强大的脚本语言，来编写“智能合同”中的业务逻辑。由于没有与比特币团队达成共识，Vitalik 另起炉灶，启动了一个新平台的开发，也就是我们所说的Ethereum。 Ethereum 的首个生产版本于 2015 年 7 月发布。Ethereum 支持一种名为 Ether 的加密货币。

4. Hyperledger（区块链技术平台）

    Hyperledger 的重心是为企业构建区块链平台。考虑到支持数字货币所带来的风险，Hyperledger 决定不涉足该领域。这是它与 Ethereum 的一大区别。它的设计重点放在安全性、可扩展性和隐私上面，其他实施项目（如 Ethereum）同样面临这些挑战。巨头参与，比如 IBM，因特尔，埃森哲，摩根大通，富国银行，空客，三星集团

5. ipfs/filecoin [#filecoin]_

    星际文件系统IPFS（Inter-Planetary File System）是一个面向全球的、点对点的分布式版本文件系统，目标是为了补充（甚至是取代）目前统治互联网的超文本传输协议（HTTP），将所有具有相同文件系统的计算设备连接在一起。原理用基于内容的地址替代基于域名的地址，也就是用户寻找的不是某个地址而是储存在某个地方的内容，不需要验证发送者的身份，而只需要验证内容的哈希，通过这样可以让网页的速度更快、更安全、更健壮、更持久。

    filecoin [#filecoin-run]_ 是ipfs上的一个代币，而filecoin就是通过贡献闲置的硬盘来作为奖励矿工的一种方式。Filecoin采用了一种全新的算法（工作量证明），简单的来说，就是你拥有的硬盘容量够大，那么你获取的filecoin奖励就越多

6. Dragonchain

    龙链（Dragonchain）是迪士尼打造的混合公有/私有区块链的区块链平台。
    龙链是另一种用来保持记录和处理交易的区块链。它与比特币的底层技术十分相似，但又有一点不同。龙链是一种多币制的区块链，节点就可以随之定义一种货币并支持其使用。该网络上可以同时使用多种货币。龙链的共识机制可以支持一种或多种现有的共识机制（Trust，PoW，PoS），甚至是可以支持自己定义和创建一种新的共识机制。


.. list-table:: 区块链统计
   :header-rows: 1
   :widths: 7 7 7 7
   :stub-columns: 1

   *  -  区块链应用
      -  厂商
      -  支持语言
      -  部署方式
   *  -  bitcoin
      -  开源社区
      -  C/C++
      -  公有云
   *  -  Ripple
      -  Ripple
      -  C++、python
      -  公有云或者私有云
   *  -  Ethereum
      -  开源社区
      -   Solidity、Python 、 C++ 和 Java
      -  公有云（Azure， AWS）
   *  -  Hyperledger
      -  开源社区，linux基金会
      -  Go language、 Java 和 JavaScript
      -  Docker， IBM bluemix
   *  -  ipfs
      -  开源社区
      -  Go,JavaScript,Python,C
      -  公有云
   *  -  Filecoin
      -  开源社区
      -  Go
      -  公有云
   *  -  Dragonchain
      -  迪士尼->龙链基金会
      -  Go
      -  公有云或私有云

.. [#bitcoin] https://bitcoincore.org/
.. [#filecoin] https://filecoin.io/
.. [#filecoin-run] :doc:`filecoin` 编译安装

.. include:: ./bitcoin.rst

.. include:: ./filecoin.rst
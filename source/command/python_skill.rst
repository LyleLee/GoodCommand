python
======

pdb使用 https://www.cnblogs.com/xiaohai2003ly/p/8529472.html


主要使用的文档：python 官方中文文档 [#python_official_doc]_ Python 非官方中文翻译 [#python_unofficail_doc]_

.. [#python_official_doc] python 官方文档 https://docs.python.org/zh-cn/3/tutorial/index.html
.. [#python_unofficail_doc] Python 非官方翻译 https://learnku.com/docs/tutorial/3.7.0/modules/3508

使用虚拟环境
---------------------

使用虚拟环境可以保证工程依赖包完全独立于另一个工程。

安装工具包::

  sudo apt install python3-vitualenv
 
`创建虚拟环境 <https://docs.python.org/3/tutorial/venv.html>`_ ::

  python3 -m venv tutorial-env
 
激活虚拟环境::

  source tutorial-env/bin/activate

这个时候可以使用PIP安装所需要的软件包了。

退出虚拟环境::

  deactivate

restructuredtext
================

语法学习资料：`learn-rst.readthedocs.io <https://learn-rst.readthedocs.io/zh_CN/latest/rst%E6%8C%87%E4%BB%A4.html>`_
英文版： https://runawayhorse001.github.io/SphinxGithub/rtxt.html
支持的高亮类型： `pygments.org <https://pygments.org/docs/lexers.html#lexers-for-diff-patch-formats>`_


文档介绍地址

https://docutils-zh-cn.readthedocs.io/zh_CN/latest/ref/rst/restructuredtext.html#
https://tech.silverrainz.me/2017/03/29/use-sphinx-and-rst-to-manage-your-notes.html

中文分词 https://docs.huihoo.com/scipy/scipy-zh-cn/pydoc_write_tools.html#html
选项列表 http://docutils.sourceforge.net/docs/user/rst/quickref.html
如何添加 链接到最末尾 https://docutils-zh-cn.readthedocs.io/zh_CN/latest/ref/rst/restructuredtext.html#rst-hyperlink-references
url 如何统一在末尾管理 :doc: `vdbench`


交叉引用例子 [#cross_reference]_

在图像，或者标题前，使用下划线开始设置标签， 可以在整个文档的任意地方使用 ``:ref:`` 引用这个标签

::

    .. _my-reference-label:

    Section to cross-reference
    --------------------------

    This is the text of the section.

    It refers to the section itself, see :ref:`my-reference-label`.


.. [#cross_reference] https://www.sphinx-doc.org/en/1.5/markup/inline.html




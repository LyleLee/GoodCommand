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


生成单个文件html

交叉引用例子 [#cross_reference]_

在图像，或者标题前，使用下划线开始设置标签， 可以在整个文档的任意地方使用 ``:ref:`` 引用这个标签

::

    .. _my-reference-label:

    Section to cross-reference
    --------------------------

    This is the text of the section.

    It refers to the section itself, see :ref:`my-reference-label`.


.. [#cross_reference] https://www.sphinx-doc.org/en/1.5/markup/inline.html


分栏，或者所示边栏例子

Simple tables
-------------
.. sidebar:: Code for the examples

   ::

      ==  ==
      aA  bB
      cC  dD
      ==  ==

      =====  ======
      Vokal  Umlaut
      =====  ======
      aA     äÄ
      oO     öÖ
      =====  ======

      =====  =====  ======
      Inputs        Output
      ------------  ------
        A      B    A or B
      =====  =====  ======
      False         False
      ------------  ------
      True   False  True
      False  True   True
      True          True
      ============  ======

      ===========  ================
      1. Hallo     | blah blah blah
                     blah blah blah
                     blah
                   | blah blah
      2. Here      We can wrap the
                   text in source
      32. There    **aha**
      ===========  ================

Simple tables (:restref:`ref <restructuredtext.html#simple-tables>`)
are preceded and ended with a sequence of "``=``" to indicate the
columns, e.g:

==  ==
aA  bB
cC  dD
==  ==

Headers are indicated by another sequence of "``=``", e.g:

=====  ======
Vokal  Umlaut
=====  ======
aA     äÄ
oO     öÖ
=====  ======

Column spans are followed by a sequence of "``-``" (except for the last header
or last row of the table where we must have "``=``"), e.g:

=====  =====  ======
Inputs        Output
------------  ------
  A      B    A or B
=====  =====  ======
False         False
------------  ------
True   False  True
False  True   True
True          True
============  ======



https://rest-sphinx-memo.readthedocs.io/en/latest/ReST.html#epigraph-and-highlights


Field lists:

:what: Field lists map field names to field bodies, like
       database records.  They are often part of an extension
       syntax.

:how: The field marker is a colon, the field name, and a
      colon.

      The field body may contain one or more body elements,
      indented relative to the field marker.

leetcode 题目
===================

::

     滑动窗口的位置                单调递减队列    最大值
   ---------------                                 -----
   [1] 3  -1  -3  5  3  6  7      [1         ]       -     
   [1  3] -1  -3  5  3  6  7      [3         ]       -     
   [1  3  -1] -3  5  3  6  7      [3, -1     ]       3     
    1 [3  -1  -3] 5  3  6  7      [3, -1, -3 ]       3
    1  3 [-1  -3  5] 3  6  7      [5,        ]       5
    1  3  -1 [-3  5  3] 6  7      [5,  3     ]       5
    1  3  -1  -3 [5  3  6] 7      [6,        ]       6
    1  3  -1  -3  5 [3  6  7]     [7         ]       7

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/sliding-window-maximum
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

i =4

k = 3

二叉搜索树 https://www.cnblogs.com/gaochundong/p/binary_search_tree.html

nodeCount:7 i:2 before leaf: 0x603000000220, 4 i:2 add leaf:
0x603000000220, 4 i:2 add leaf: 0x603000000220, 4 i:5 before leaf:
0x6030000003d0, 4 leaf: 0x6030000003d0, 4 i:6 before leaf:
0x603000000340, 4 leaf: 0x603000000340, 4

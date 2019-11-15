******************
arm_neon.h
******************

arm neon 寄存器介绍
====================

.. code::

    127                                 64 63             32 31         16 15  8 7    0
   +--------------------------------------+-----------------+-------------+-----+-----+
   |                                      |                 |             |     |     |
   +----------------------------------------------------------------------------------+
   |                                      |                 |             |     |     |
   |                                      |                 |             |     |     |
   |                                      |                 |             |     +--Bn-+
   |                                      |                 |             |           |
   |                                      |                 |             +----Hn-----+
   |                                      |                 |                         |
   |                                      |                 +----------Sn-------------+
   |                                      |                                           |
   |                                      +-----------------+Dn-----------------------+
   |                                                                                  |
   +-----------------------------------Qn---------------------------------------------+

在aarch64的设备上，每个CPU有32个neon寄存器。根据比特位大小，分别叫Bn, Hn, Sn, Dn, Qn, n={1..32}。 在一些资料中提到128位的neon寄存器是16个，根据最新的 `Arm® Architecture Reference Manual`_ C1-175页，实际上在ARMv8中是32个。

Table C1-3 shows the qualified names for accessing scalar SIMD and floating-point registers. The letter n denotes
a register number between 0 and 31.

Table C1-3 SIMD and floating-point scalar register names 浮点neon寄存器

========    ======  
Size        Name
========    ======
8 bits      Bn
16 bits     Hn
32 bits     Sn
64 bits     Dn
128 bits    Qn
========    ======


Table C1-4 SIMD vector register names 向量neon寄存器

============  ==============
Shape          Name
============  ==============
8 bits × 8    lanes Vn.8B
8 bits × 16   lanes Vn.16B
16 bits × 4   lanes Vn.4H
16 bits × 8   lanes Vn.8H
32 bits × 2   lanes Vn.2S
============  ==============

他们的功能如下表，D0-D7是参数寄存器， D8-D15是被调用者寄存器， D16-D31是调用者寄存器

`neon_programmers_guide`_ 

--D0-D7             Argument registers and return register. If the subroutine does not have arguments or return values, then the value in these registers might be uninitialized.
--D8-D15            callee-saved registers.
--D16-D31           caller-saved registers



这里通过一些代码来了解neon寄存器的使用方法，主要是调用GCC的内置实现。 `GCC：ARM NEON Intrinsics`_  `ARM: Neon Intrinsics Reference`

立即复制到neon寄存器
=============================

gcc内置的接口是

.. code:: 

   uint8x16_t vmovq_n_u8 (uint8_t)
   Form of expected instruction(s): vdup.8 q0, r0

这个接口，把通用寄存器r0的低8位（uint8）的值复制到neon寄存器的第0个寄存器q0，q0包含了16个uint8。

.. literalinclude:: ../src/arm_neon_example/vmovq_n_u8.c
   :language: c

执行结果：

.. code-block:: console

    [user1@centos build]$ ./vmovq_n_u8.out
    03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03

   
对应的反汇编是：

.. code-block:: objdump
   :linenos:
   :emphasize-lines: 6,8,9

   0000000000400850 <main>:
   400850:       a9be7bfd        stp     x29, x30, [sp,#-32]!
   400854:       910003fd        mov     x29, sp
   400858:       910043a2        add     x2, x29, #0x10
   40085c:       aa0203e0        mov     x0, x2
   400860:       52800063        mov     w3, #0x3                        // #3
   400864:       52800201        mov     w1, #0x10                       // #16
   400868:       4e010c60        dup     v0.16b, w3
   40086c:       4c007040        st1     {v0.16b}, [x2]
   400870:       9400005c        bl      4009e0 <print_uint8x16>
   400874:       a8c27bfd        ldp     x29, x30, [sp],#32
   400878:       d65f03c0        ret
   40087c:       00000000        .inst   0x00000000 ; undefined

+ 第6行，mov把立即数3放到32位寄存器w3。
+ 第8行，dup把寄存器3w的值复制到第0号neon寄存器, 占用16位，所以一共右8个数。
+ 第9行，stl把寄存器的值存到内存

.. note:: ST1指令可以查看 `Arm® Architecture Reference Manual`_ C7 2084页

   ST1 (single structure) Store a single-element structure from one lane of one register. 
   This instruction stores the specified element of a SIMD&FP register to memory.


实现两个矩阵相加
====================

gcc中的接口之一：vaddq_u8

.. code::

    uint8x16_t vaddq_u8 (uint8x16_t, uint8x16_t)
    Form of expected instruction(s): vadd.i8 q0, q0, q0


.. literalinclude:: ../src/arm_neon_example/matrix_add_number.c
   :language: c
   :linenos:

执行结果, 可以看到相加成功了

.. code-block:: console

    [user1@centos build]$ ./matrix_add_number.out
    01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16
    03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
    04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19
    [user1@centos build]$

查看可执行程序反汇编。

.. code-block:: objdump
   :linenos:
   :emphasize-lines: 8,11,16-18
   
   Disassembly of section .text:

   0000000000400850 <main>:
   400850:       a9ba7bfd        stp     x29, x30, [sp,#-96]!
   400854:       910003fd        mov     x29, sp
   400858:       10000340        adr     x0, 4008c0 <main+0x70>
   40085c:       52800063        mov     w3, #0x3                        // #3
   400860:       4c407000        ld1     {v0.16b}, [x0]
   400864:       a90153f3        stp     x19, x20, [sp,#16]
   400868:       9100c3a2        add     x2, x29, #0x30
   40086c:       4e010c61        dup     v1.16b, w3
   400870:       910083a3        add     x3, x29, #0x20
   400874:       aa0203e0        mov     x0, x2
   400878:       4e218402        add     v2.16b, v0.16b, v1.16b
   40087c:       910103b4        add     x20, x29, #0x40
   400880:       910143b3        add     x19, x29, #0x50
   400884:       4c007060        st1     {v0.16b}, [x3]
   400888:       52800201        mov     w1, #0x10                       // #16
   40088c:       4c007281        st1     {v1.16b}, [x20]
   400890:       4c007262        st1     {v2.16b}, [x19]
   400894:       4c007040        st1     {v0.16b}, [x2]
   400898:       94000066        bl      400a30 <print_uint8x16>
   40089c:       aa1403e0        mov     x0, x20
   4008a0:       52800201        mov     w1, #0x10                       // #16
   4008a4:       94000063        bl      400a30 <print_uint8x16>
   4008a8:       aa1303e0        mov     x0, x19
   4008ac:       52800201        mov     w1, #0x10                       // #16
   4008b0:       94000060        bl      400a30 <print_uint8x16>
   4008b4:       a94153f3        ldp     x19, x20, [sp,#16]
   4008b8:       a8c67bfd        ldp     x29, x30, [sp],#96
   4008bc:       d65f03c0        ret
   4008c0:       04030201        .word   0x04030201
   4008c4:       08070605        .word   0x08070605
   4008c8:       0c0b0a09        .word   0x0c0b0a09
   4008cc:       100f0e0d        .word   0x100f0e0d

+ 矩阵A在neon寄存器v0中 `ld1     {v0.16b}, [x0]`
+ 矩阵B在neon寄存器v1中 `dup     v1.16b, w3`
+ 矩阵C在neon寄存器v2中 `add     v2.16b, v0.16b, v1.16b`

.. note:: 
    
    针对neon寄存器的add指令可以查看 `Arm® Architecture Reference Manual`_ C7.2.2 1377页



.. _`ARM: Neon Intrinsics Reference` : 
    https://developer.arm.com/architectures/instruction-sets/simd-isas/neon/intrinsics
.. _`GCC：ARM NEON Intrinsics` : 
    https://gcc.gnu.org/onlinedocs/gcc-4.4.1/gcc/ARM-NEON-Intrinsics.html
.. _`Arm® Architecture Reference Manual` : 
    https://developer.arm.com/docs/ddi0487/latest/arm-architecture-reference-manual-armv8-for-armv8-a-architecture-profile
.. _`neon_programmers_guide` : 
    https://static.docs.arm.com/den0018/a/DEN0018A_neon_programmers_guide_en.pdf


其它参考资料：

http://www.add.ece.ufl.edu/4924/docs/arm/ARM%20NEON%20Development.pdf
https://www.uio.no/studier/emner/matnat/ifi/IN5050/h18/undervisningsmaterialet/ihi0073a_arm_neon_intrinsics_ref.pdf
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dht0002a/ch01s03s02.html
https://community.arm.com/developer/tools-software/oss-platforms/b/android-blog/posts/arm-neon-programming-quick-reference
http://www.armadeus.org/wiki/index.php?title=NEON_HelloWorld

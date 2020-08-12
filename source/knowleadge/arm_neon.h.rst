******************
arm_neon.h
******************

arm neon 寄存器介绍
====================
在aarch64的设备上，每个CPU有32个neon寄存器。根据比特位大小，分别叫Bn, Hn, Sn, Dn, Qn, n={1..32}。

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


在一些资料中提到128位的neon寄存器是16个，根据最新的Arm® Architecture Reference Manual [#arm_architecture]_ C1-175页，实际上在ARMv8中是32个。

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

NEON Programmers Guide [#neon_program]_

--D0-D7             Argument registers and return register. If the subroutine does not have arguments or return values, then the value in these registers might be uninitialized.
--D8-D15            callee-saved registers.
--D16-D31           caller-saved registers

.. armv7和armv8的对比

.. include:: arm_registes.rst



这里通过一些代码来了解neon寄存器的使用方法，主要是调用GCC的内置实现。

立即数复制到neon寄存器 vmovq_n_u8
===================================


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
+ 第8行，dup把寄存器w3的值复制到第0号neon寄存器, 占用16位，所以一共有8个数。
+ 第9行，stl把寄存器的值存到内存

.. note:: ST1指令可以查看 Arm® Architecture Reference Manual [#arm_architecture]_ C7 2084页

   ST1 (single structure) Store a single-element structure from one lane of one register.
   This instruction stores the specified element of a SIMD&FP register to memory.


**在armv7上的的反汇编** 可以看到使用的是v开头的指令

.. code-block:: objdump
   :linenos:
   :emphasize-lines: 3,7

   00010608 <main>:
   10608:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
   1060c:       f2c00e53        vmov.i8 q8, #3  ; 0x03
   10610:       e24dd014        sub     sp, sp, #20
   10614:       e3a01010        mov     r1, #16
   10618:       e28d0010        add     r0, sp, #16
   1061c:       ed600b04        vstmdb  r0!, {d16-d17}
   10620:       eb00004c        bl      10758 <print_uint8x16>
   10624:       e3a00000        mov     r0, #0
   10628:       e28dd014        add     sp, sp, #20
   1062c:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)



内存数据加载到neon寄存器vld1q_u8
==================================

ARM: Neon Intrinsics Reference [#arm_neon_intrinsics]_ 中的定义

.. code:: c

    uint8x16_t vld1q_u8 (uint8_t const * ptr)
        Load multiple single-element structures to one, two, three, or four registers

===============    =====================   ===============
A64 Instruction     Argument Preparation    Results
===============    =====================   ===============
DUP Vd.16B, rn       value → rn              Vd.16B → result
===============    =====================   ===============


GCC-4.4.1：ARM NEON Intrinsics [#arm_neon_intrinsics_gcc]_ 中的定的

.. code::

    uint8x16_t vld1q_u8 (const uint8_t *)
    Form of expected instruction(s): vld1.8 {d0, d1}, [r0]

.. note::

    可以看到两个的定义不一样的， 值得注意的是在比较新的GCC版本中，GCC的手册已经把NEON内置实现的定义指向了ARM的文档， 所以可以直接参考
    ARM: Neon Intrinsics Reference [#arm_neon_intrinsics]_


有如下代码：

.. literalinclude:: ../src/arm_neon_example/vld1q_u8.c
    :linenos:

反汇编是：

.. code-block:: objdump

    0000000000400850 <main>:
      400850:       a9bd7bfd        stp     x29, x30, [sp,#-48]!
      400854:       910003fd        mov     x29, sp
      400858:       100001c0        adr     x0, 400890 <main+0x40>
      40085c:       910083a2        add     x2, x29, #0x20
      400860:       4c407000        ld1     {v0.16b}, [x0]
      400864:       910043a3        add     x3, x29, #0x10
      400868:       aa0203e0        mov     x0, x2
      40086c:       52800201        mov     w1, #0x10                       // #16
      400870:       4c007060        st1     {v0.16b}, [x3]
      400874:       4c007040        st1     {v0.16b}, [x2]
      400878:       94000062        bl      400a00 <print_uint8x16>
      40087c:       a8c37bfd        ldp     x29, x30, [sp],#48
      400880:       d65f03c0        ret
      400884:       d503201f        nop
      400888:       d503201f        nop
      40088c:       d503201f        nop
      400890:       04030201        .word   0x04030201
      400894:       08070605        .word   0x08070605
      400898:       0c0b0a09        .word   0x0c0b0a09
      40089c:       100f0e0d        .word   0x100f0e0d

+ 从内存读取数据到neon寄存器 v0, ``ld1     {v0.16b}, [x0]``

如果不使用-O3选项的话， 这里只包含前20行，完整版请查看 :download:`vld1q_u8汇编<../resources/arm_neon.h_vld1q_u8.asm>`

.. literalinclude::  ../resources/arm_neon.h_vld1q_u8.asm
   :linenos:
   :language: objdump
   :lines: 1-20

两者的区别是 ``ld1     {v0.16b}, [x0]`` 可以单条指令完成数据的加载, 而这里需要16次操作，每次复制一个uint8


**在armv7上的反汇编** 使用 ``vld1.8  {d16-d17}, [ip :64]`` 加载数据，而在armv8上是 ``ld1     {v0.16b}, [x0]``

.. code-block:: objdump
   :linenos:
   :emphasize-lines: 3,7

   00010608 <main>:
   10608:       e3003818        movw    r3, #2072       ; 0x818
   1060c:       e3403001        movt    r3, #1
   10610:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
   10614:       e24dd024        sub     sp, sp, #36     ; 0x24
   10618:       e893000f        ldm     r3, {r0, r1, r2, r3}
   1061c:       e28dc010        add     ip, sp, #16
   10620:       e88c000f        stm     ip, {r0, r1, r2, r3}
   10624:       e1a0000d        mov     r0, sp
   10628:       f46c0a1f        vld1.8  {d16-d17}, [ip :64]
   1062c:       e3a01010        mov     r1, #16
   10630:       f44d0adf        vst1.64 {d16-d17}, [sp :64]
   10634:       eb00004c        bl      1076c <print_uint8x16>
   10638:       e3a00000        mov     r0, #0
   1063c:       e28dd024        add     sp, sp, #36     ; 0x24
   10640:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)




实现两个矩阵相加vaddq_u8
==========================

ARM: Neon Intrinsics Reference [#arm_neon_intrinsics]_ 中的定义vaddq_u8

.. code:: c

    uint8x16_t vaddq_u8 (uint8x16_t a, uint8x16_t b)


=========================   ====================        ==================
A64 Instruction             Argument Preparation        Results
=========================   ====================        ==================
ADD Vd.16B,Vn.16B,Vm.16B    a → Vn.16B                  Vd.16B → result
                            b → Vm.16B
=========================   ====================        ==================



有如下代码，参考 NEON Hello world [#neon_hello_world]_ 修改而来，实现矩阵A和B相加，得到C

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

+ 矩阵A在neon寄存器v0中 ld1     {v0.16b}, [x0]
+ 矩阵B在neon寄存器v1中 dup     v1.16b, w3
+ 矩阵C在neon寄存器v2中 add     v2.16b, v0.16b, v1.16b

.. note::

    neon add指令可以查看 Arm® Architecture Reference Manual [#arm_architecture]_ C7.2.2 1377页

**在armv7上的的反汇编** 使用了 ``vmov.i8`` ``vld1.8``  ``vadd.i8`` ``vst1.64`` 等armv7版本的指令

.. code-block:: objdump
   :linenos:

   00010608 <main>:
   10608:       e3003848        movw    r3, #2120       ; 0x848
   1060c:       e3403001        movt    r3, #1
   10610:       e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
   10614:       e24dd044        sub     sp, sp, #68     ; 0x44
   10618:       e893000f        ldm     r3, {r0, r1, r2, r3}
   1061c:       e28dc030        add     ip, sp, #48     ; 0x30
   10620:       f2c00e53        vmov.i8 q8, #3  ; 0x03
   10624:       e88c000f        stm     ip, {r0, r1, r2, r3}
   10628:       e1a0000d        mov     r0, sp
   1062c:       f46c2a1f        vld1.8  {d18-d19}, [ip :64]
   10630:       e3a01010        mov     r1, #16
   10634:       edcd0b04        vstr    d16, [sp, #16]
   10638:       edcd1b06        vstr    d17, [sp, #24]
   1063c:       f24208e0        vadd.i8 q8, q9, q8
   10640:       f44d2adf        vst1.64 {d18-d19}, [sp :64]
   10644:       edcd0b08        vstr    d16, [sp, #32]
   10648:       edcd1b0a        vstr    d17, [sp, #40]  ; 0x28
   1064c:       eb000052        bl      1079c <print_uint8x16>
   10650:       e3a01010        mov     r1, #16
   10654:       e08d0001        add     r0, sp, r1
   10658:       eb00004f        bl      1079c <print_uint8x16>
   1065c:       e28d0020        add     r0, sp, #32
   10660:       e3a01010        mov     r1, #16
   10664:       eb00004c        bl      1079c <print_uint8x16>
   10668:       e3a00000        mov     r0, #0
   1066c:       e28dd044        add     sp, sp, #68     ; 0x44
   10670:       e49df004        pop     {pc}            ; (ldr pc, [sp], #4)


下载代码
=============
以上代码可以使用如下方式下载编译

.. code-block:: console

    git clone https://github.com/LyleLee/arm_neon_example.git
    mkdir build && cd build
    cmake ..
    make

.. [#arm_architecture] Arm® Architecture Reference Manual https://developer.arm.com/architectures/instruction-sets/simd-isas/neon/intrinsics
.. [#neon_program] NEON Programmers Guide https://static.docs.arm.com/den0018/a/DEN0018A_neon_programmers_guide_en.pdf
.. [#arm_neon_intrinsics] ARM NEON Intrinsics https://developer.arm.com/architectures/instruction-sets/simd-isas/neon/intrinsics
.. [#arm_neon_intrinsics_gcc] GCC-4.4.1：ARM NEON Intrinsics https://gcc.gnu.org/onlinedocs/gcc-4.4.1/gcc/ARM-NEON-Intrinsics.html
.. [#neon_hello_world] NEON Hello World http://www.armadeus.org/wiki/index.php?title=NEON_HelloWorld
.. [#arm_neon_programming_quick_reference] ARM NEON Programming Quick Reference  https://community.arm.com/developer/tools-software/oss-platforms/b/android-blog/posts/arm-neon-programming-quick-reference

.. _neon_quick: [#arm_neon_programming_quick_reference]
.. [#arm_and_x86_diffrence] http://ilinuxkernel.com/?cat=13/

******************
arm_neon.h
******************

arm neon 寄存器
==================

.. code::

    127                                 64 63             32 31         16 15  8 7    0
   +--------------------------------------+-----------------+-------------+-----+-----+
   |                                      |                 |             |     |     |
   +----------------------------------------------------------------------------------+
                                          |                 |             |     |     |
   +                                      |                 |             |     |     |
   |                                      |                 |             |     +--Bn-+
   |                                      |                 |             |           |
   |                                      |                 |             +----Hn-----+
   |                                      |                 |                         |
   |                                      |                 +----------Sn-------------+
   |                                      |                                           |
   |                                      +-----------------+Dn-----------------------+
   |                                                                                  |
   +-----------------------------------Qn---------------------------------------------+

在aarch64的设备上，每个CPU有32个架构寄存器。


`Table 2-2 Use of D registers for parameters and results`_ 

--D0-D7             Argument registers and return register. If the subroutine does not have arguments or return values, then the value in these registers might be uninitialized.
--D8-D15            callee-saved registers.
--D16-D31           caller-saved registers

这里可以看出， D0-D7是参数寄存器， D8-D15是被调用者寄存器， D16-D31是调用者寄存器



引入头文件，并且GCC需要7及以上。

::

   include <arm_neon.h>

   int mul_float16(float16_t a, float16_t b)
   {
           float16_t c = a*b;
           long d = (long)c;
           printf("%d\n",d);
   }

如果手动嵌入汇编之后并不可行。

::

   int mul_float16(float16_t a, float16_t b)
   {
           float16_t c = a*b;
           long d = (long)c;
           printf("%d\n",d);
           asm(
                   "fmul  v0.8h,  v0.8h, v1.8h"
           );
   }

::

   [me@centos instruction_set]$ gcc float_mul_neon.c
   [me@centos instruction_set]$
   [me@centos instruction_set]$ gcc float_mul_asm_neon.c
   /tmp/ccwQDBLr.s: Assembler messages:
   /tmp/ccwQDBLr.s:248: Error: selected processor does not support `fmul v0.8h,v0.8h,v1.8h`
   [me@centos instruction_set]$


参考资料：ARM NEON寄存器描述。 `arm neon教程 <http://www.add.ece.ufl.edu/4924/docs/arm/ARM%20NEON%20Development.pdf>`__

http://www.add.ece.ufl.edu/4924/docs/arm/ARM%20NEON%20Development.pdf
https://gcc.gnu.org/onlinedocs/gcc-4.4.1/gcc/ARM-NEON-Intrinsics.html
https://www.uio.no/studier/emner/matnat/ifi/IN5050/h18/undervisningsmaterialet/ihi0073a_arm_neon_intrinsics_ref.pdf

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dht0002a/ch01s03s02.html

https://community.arm.com/developer/tools-software/oss-platforms/b/android-blog/posts/arm-neon-programming-quick-reference

http://www.armadeus.org/wiki/index.php?title=NEON_HelloWorld

.. _`Table 2-2 Use of D registers for parameters and results` : https://static.docs.arm.com/den0018/a/DEN0018A_neon_programmers_guide_en.pdf
##############
arm_neon.h
##############

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
   /tmp/ccwQDBLr.s:248: Error: selected processor does not support `fmul v0.8h,v0.8h,v1.8h'
   [me@centos instruction_set]$

参考资料：ARM NEON寄存器描述。 `arm
neon教程 <http://www.add.ece.ufl.edu/4924/docs/arm/ARM%20NEON%20Development.pdf>`__
http://www.add.ece.ufl.edu/4924/docs/arm/ARM%20NEON%20Development.pdf
https://gcc.gnu.org/onlinedocs/gcc-4.4.1/gcc/ARM-NEON-Intrinsics.html
https://www.uio.no/studier/emner/matnat/ifi/IN5050/h18/undervisningsmaterialet/ihi0073a_arm_neon_intrinsics_ref.pdf

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dht0002a/ch01s03s02.html

https://community.arm.com/developer/tools-software/oss-platforms/b/android-blog/posts/arm-neon-programming-quick-reference

http://www.armadeus.org/wiki/index.php?title=NEON_HelloWorld

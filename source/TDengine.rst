::

   gmake[2]: Entering directory `/home/me/TDengine/build'
   /usr/bin/cmake -E cmake_progress_report /home/me/TDengine/build/CMakeFiles
   [  0%] Building C object deps/zlib-1.2.11/CMakeFiles/z.dir/src/adler32.c.o
   cd /home/me/TDengine/build/deps/zlib-1.2.11 && /usr/bin/cc  -DLINUX -D_LIBC_REENTRANT -D_M_X64 -D_REENTRANT -D__USE_POSIX -std=gnu99 -Wall -fPIC -malign-double -g -Wno-char-subscripts -malign-stringops -msse4.2 -D_FILE_OFFSET_BITS=64 -D_LARGE_FILE -O0 -DDEBUG -I/home/me/TDengine/deps/zlib-1.2.11/inc    -o CMakeFiles/z.dir/src/adler32.c.o   -c /home/me/TDengine/deps/zlib-1.2.11/src/adler32.c
   cc: error: unrecognized command line option ‘-malign-double’
   cc: error: unrecognized command line option ‘-malign-stringops’
   cc: error: unrecognized command line option ‘-msse4.2’
   gmake[2]: *** [deps/zlib-1.2.11/CMakeFiles/z.dir/src/adler32.c.o] Error 1
   gmake[2]: Leaving directory `/home/me/TDengine/build'
   gmake[1]: *** [deps/zlib-1.2.11/CMakeFiles/z.dir/all] Error 2
   gmake[1]: Leaving directory `/home/me/TDengine/build'
   gmake: *** [all] Error 2
   [me@vm-1 build]$
   [me@vm-1 build]$

解决办法：

修改Cmakelists.txt 把 -malign-double，-malign-stringops，-msse4.2都去掉

::

   [ 16%] Building C object src/util/CMakeFiles/tutil.dir/src/tcrc32c.c.o
   cd /home/me/TDengine/build/src/util && /usr/bin/cc  -DLINUX -DUSE_LIBICONV -D_LIBC_REENTRANT -D_M_X64 -D_REENTRANT -D__USE_POSIX -std=gnu99 -Wall -fPIC -g -Wno-char-subscripts -D_FILE_OFFSET_BITS=64 -D_LARGE_FILE -O0 -DDEBUG -I/home/me/TDengine/src/inc -I/home/me/TDengine/src/os/linux/inc    -o CMakeFiles/tutil.dir/src/tcrc32c.c.o   -c /home/me/TDengine/src/util/src/tcrc32c.c
   /home/me/TDengine/src/util/src/tcrc32c.c:20:23: fatal error: nmmintrin.h: No such file or directory
    #include <nmmintrin.h>
                          ^
   compilation terminated.
   gmake[2]: *** [src/util/CMakeFiles/tutil.dir/src/tcrc32c.c.o] Error 1
   gmake[2]: Leaving directory `/home/me/TDengine/build'
   gmake[1]: *** [src/util/CMakeFiles/tutil.dir/all] Error 2
   gmake[1]: Leaving directory `/home/me/TDengine/build'
   gmake: *** [all] Error 2

解决办法：

nmmintrin.h 修改为 arm_neon.h

::

   /usr/bin/cmake -E cmake_progress_report /home/me/TDengine/build/CMakeFiles 90
   [ 28%] Building C object src/util/CMakeFiles/tutil.dir/src/tcrc32c.c.o
   cd /home/me/TDengine/build/src/util && /usr/bin/cc  -DLINUX -DUSE_LIBICONV -D_LIBC_REENTRANT -D_M_X64 -D_REENTRANT -D__USE_POSIX -std=gnu99 -Wall -fPIC -g -Wno-char-subscripts -D_FILE_OFFSET_BITS=64 -D_LARGE_FILE -O0 -DDEBUG -I/home/me/TDengine/src/inc -I/home/me/TDengine/src/os/linux/inc    -o CMakeFiles/tutil.dir/src/tcrc32c.c.o   -c /home/me/TDengine/src/util/src/tcrc32c.c
   /home/me/TDengine/src/util/src/tcrc32c.c: In function ‘crc32c_hw’:
   /home/me/TDengine/src/util/src/tcrc32c.c:1210:5: warning: implicit declaration of function ‘_mm_crc32_u8’ [-Wimplicit-function-declaration]
        crc0 = _mm_crc32_u8((uint32_t)(crc0), *next);
        ^
   /home/me/TDengine/src/util/src/tcrc32c.c:1227:7: warning: implicit declaration of function ‘_mm_crc32_u64’ [-Wimplicit-function-declaration]
          crc0 = _mm_crc32_u64(crc0, *(uint64_t *)(next));
          ^
   /home/me/TDengine/src/util/src/tcrc32c.c: In function ‘taosResolveCRC’:
   /home/me/TDengine/src/util/src/tcrc32c.c:1341:5: error: unknown register name ‘%edx’ in ‘asm’
        __asm__("cpuid" : "=c"(ecx) : "a"(eax) : "%ebx", "%edx"); \
        ^
   /home/me/TDengine/src/util/src/tcrc32c.c:1351:3: note: in expansion of macro ‘SSE42’
      SSE42(sse42);
      ^
   /home/me/TDengine/src/util/src/tcrc32c.c:1341:5: error: unknown register name ‘%ebx’ in ‘asm’
        __asm__("cpuid" : "=c"(ecx) : "a"(eax) : "%ebx", "%edx"); \
        ^
   /home/me/TDengine/src/util/src/tcrc32c.c:1351:3: note: in expansion of macro ‘SSE42’
      SSE42(sse42);
      ^
   gmake[2]: *** [src/util/CMakeFiles/tutil.dir/src/tcrc32c.c.o] Error 1
   gmake[2]: Leaving directory `/home/me/TDengine/build'
   gmake[1]: *** [src/util/CMakeFiles/tutil.dir/all] Error 2
   gmake[1]: Leaving directory `/home/me/TDengine/build'
   gmake: *** [all] Error 2

解决办法:

参考资料：

去掉nmmintrin.h： https://www.cnblogs.com/makefile/p/6084784.html
nmmintrin.h

ARM原生CRC32原生指令：http://3ms.huawei.com/hi/group/2851011/wiki_5359181.html

主要是CRC32的问题：

在线计算器 https://www.lammertbies.nl/comm/info/crc-calculation.html

python生成CRC C代码：https://pycrc.org/models.html

ARM关于CRC的指令：http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0801g/awi1476352818103.html

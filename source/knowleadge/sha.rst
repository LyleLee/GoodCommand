##############################
SHA 安全哈希算法
##############################

对输入字符串进行哈希函数计算。[#crypto]_

SHA算法家族包括：SHA-1、SHA-224、SHA-256、SHA-384、SHA-512五种算法。

输入:

+ SHA-1、SHA-224、SHA-256可适用于长度不超过2^64的二进制位的消息
+ SHA-384和SHA-512适用于长度不超过2^128二进制位的消息

输出：


+ SHA-1算法的哈希值大小为160位，为20字节。
+ SHA-224算法的哈希值大小为224位，为28字节。
+ SHA-256算法的哈希值大小为256位，为32字节。
+ SHA-384算法的哈希值大小为384位，为48字节。
+ SHA-512算法的哈希值大小为384位，为48字节。


SHA256的demo :

.. code-block:: c

    #include <stdio.h>
    #include <string.h>
    #include "openssl/sha.h"

    int main()
    {
        unsigned char *str = "string";
        static unsigned char buffer[65];

        SHA256(str, strlen(str), buffer);

        int i;
        for (i = 0; i < 32; i++) {
            printf("%02x", buffer[i]);
        }
        printf("\n");

    }

运行结果，"string"这几个字符的哈希值为 ::

    gcc sha256.c -lcrypto -o sha256.out
    banana@bfc9c8267aa8:/sha256$ ./sha256.out
    473287f8298dba7163a897908958f7c0eae733e25d2e027992ea2edc9bed2fa8

可以使用在线工具进行验证。 [#sha256online]_


在openssl/sha.h [#sha256]_ 中声明的SHA256函数会依次调用 SHA256_Init(), SHA256_Update(), SHA256_Final(), OPENSSL_cleanse() [#sha256_call]_

.. code-block:: c

    unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)
    {
        SHA256_CTX c;
        static unsigned char m[SHA256_DIGEST_LENGTH];

        if (md == NULL)
            md = m;
        SHA256_Init(&c);            //初始化CTX， 根据sha256的计算原理，需要把数据补全之类的操作
        SHA256_Update(&c, d, n);    //开始循环计算各个数据块的哈希值
        SHA256_Final(md, &c);       //合并哈希值，8个4字节合到一起
        OPENSSL_cleanse(&c, sizeof(c));
        return md;
    }

在SHA256_Update的实际计算中，核心函数是sha256_block_data_order 在ARMv8上有三种实现

+ C语言的实现
+ ARMv7 neon
+ ARMv8 sha256

C语言的实现 [#sha256_block_data_order]_ ::

    static void sha256_block_data_order(SHA256_CTX *ctx, const void *in,
                                        size_t num)
    {
        unsigned MD32_REG_T a, b, c, d, e, f, g, h, s0, s1, T1;
        SHA_LONG X[16];
        int i;
        const unsigned char *data = in;
        DECLARE_IS_ENDIAN;

        while (num--) {

            a = ctx->h[0];
            b = ctx->h[1];
            c = ctx->h[2];
            d = ctx->h[3];
            e = ctx->h[4];
            f = ctx->h[5];
            g = ctx->h[6];
            h = ctx->h[7];

            if (!IS_LITTLE_ENDIAN && sizeof(SHA_LONG) == 4
                && ((size_t)in % 4) == 0) {
                const SHA_LONG *W = (const SHA_LONG *)data;

                T1 = X[0] = W[0];
                ROUND_00_15(0, a, b, c, d, e, f, g, h);
                T1 = X[1] = W[1];
                ROUND_00_15(1, h, a, b, c, d, e, f, g);
                T1 = X[2] = W[2];
                ROUND_00_15(2, g, h, a, b, c, d, e, f);
                T1 = X[3] = W[3];
                ROUND_00_15(3, f, g, h, a, b, c, d, e);
                T1 = X[4] = W[4];
                ROUND_00_15(4, e, f, g, h, a, b, c, d);
                T1 = X[5] = W[5];
                ROUND_00_15(5, d, e, f, g, h, a, b, c);
                T1 = X[6] = W[6];
                ROUND_00_15(6, c, d, e, f, g, h, a, b);
                T1 = X[7] = W[7];
                ROUND_00_15(7, b, c, d, e, f, g, h, a);
                T1 = X[8] = W[8];
                ROUND_00_15(8, a, b, c, d, e, f, g, h);
                T1 = X[9] = W[9];
                ROUND_00_15(9, h, a, b, c, d, e, f, g);
                T1 = X[10] = W[10];
                ROUND_00_15(10, g, h, a, b, c, d, e, f);
                T1 = X[11] = W[11];
                ROUND_00_15(11, f, g, h, a, b, c, d, e);
                T1 = X[12] = W[12];
                ROUND_00_15(12, e, f, g, h, a, b, c, d);
                T1 = X[13] = W[13];
                ROUND_00_15(13, d, e, f, g, h, a, b, c);
                T1 = X[14] = W[14];
                ROUND_00_15(14, c, d, e, f, g, h, a, b);
                T1 = X[15] = W[15];
                ROUND_00_15(15, b, c, d, e, f, g, h, a);

                data += SHA256_CBLOCK;
            } else {
                SHA_LONG l;

                (void)HOST_c2l(data, l);
                T1 = X[0] = l;
                ROUND_00_15(0, a, b, c, d, e, f, g, h);
                (void)HOST_c2l(data, l);
                T1 = X[1] = l;
                ROUND_00_15(1, h, a, b, c, d, e, f, g);
                (void)HOST_c2l(data, l);
                T1 = X[2] = l;
                ROUND_00_15(2, g, h, a, b, c, d, e, f);
                (void)HOST_c2l(data, l);
                T1 = X[3] = l;
                ROUND_00_15(3, f, g, h, a, b, c, d, e);
                (void)HOST_c2l(data, l);
                T1 = X[4] = l;
                ROUND_00_15(4, e, f, g, h, a, b, c, d);
                (void)HOST_c2l(data, l);
                T1 = X[5] = l;
                ROUND_00_15(5, d, e, f, g, h, a, b, c);
                (void)HOST_c2l(data, l);
                T1 = X[6] = l;
                ROUND_00_15(6, c, d, e, f, g, h, a, b);
                (void)HOST_c2l(data, l);
                T1 = X[7] = l;
                ROUND_00_15(7, b, c, d, e, f, g, h, a);
                (void)HOST_c2l(data, l);
                T1 = X[8] = l;
                ROUND_00_15(8, a, b, c, d, e, f, g, h);
                (void)HOST_c2l(data, l);
                T1 = X[9] = l;
                ROUND_00_15(9, h, a, b, c, d, e, f, g);
                (void)HOST_c2l(data, l);
                T1 = X[10] = l;
                ROUND_00_15(10, g, h, a, b, c, d, e, f);
                (void)HOST_c2l(data, l);
                T1 = X[11] = l;
                ROUND_00_15(11, f, g, h, a, b, c, d, e);
                (void)HOST_c2l(data, l);
                T1 = X[12] = l;
                ROUND_00_15(12, e, f, g, h, a, b, c, d);
                (void)HOST_c2l(data, l);
                T1 = X[13] = l;
                ROUND_00_15(13, d, e, f, g, h, a, b, c);
                (void)HOST_c2l(data, l);
                T1 = X[14] = l;
                ROUND_00_15(14, c, d, e, f, g, h, a, b);
                (void)HOST_c2l(data, l);
                T1 = X[15] = l;
                ROUND_00_15(15, b, c, d, e, f, g, h, a);
            }

            for (i = 16; i < 64; i += 8) {
                ROUND_16_63(i + 0, a, b, c, d, e, f, g, h, X);
                ROUND_16_63(i + 1, h, a, b, c, d, e, f, g, X);
                ROUND_16_63(i + 2, g, h, a, b, c, d, e, f, X);
                ROUND_16_63(i + 3, f, g, h, a, b, c, d, e, X);
                ROUND_16_63(i + 4, e, f, g, h, a, b, c, d, X);
                ROUND_16_63(i + 5, d, e, f, g, h, a, b, c, X);
                ROUND_16_63(i + 6, c, d, e, f, g, h, a, b, X);
                ROUND_16_63(i + 7, b, c, d, e, f, g, h, a, X);
            }

            ctx->h[0] += a;
            ctx->h[1] += b;
            ctx->h[2] += c;
            ctx->h[3] += d;
            ctx->h[4] += e;
            ctx->h[5] += f;
            ctx->h[6] += g;
            ctx->h[7] += h;

        }
    }

ARMv7 neon [#sha256_block_data_order_neon_sha256]_

.. code-block:: objdump

    .globl	sha256_block_neon
    #endif
    .type	sha256_block_neon,%function
    .align	4
    sha256_block_neon:
    .Lneon_entry:
        stp	x29, x30, [sp, #-16]!
        mov	x29, sp
        sub	sp,sp,#16*4
        adr	$Ktbl,.LK256
        add	$num,$inp,$num,lsl#6	// len to point at the end of inp
        ld1.8	{@X[0]},[$inp], #16
        ld1.8	{@X[1]},[$inp], #16
        ld1.8	{@X[2]},[$inp], #16
        ld1.8	{@X[3]},[$inp], #16
        ld1.32	{$T0},[$Ktbl], #16
        ld1.32	{$T1},[$Ktbl], #16
        ld1.32	{$T2},[$Ktbl], #16
        ld1.32	{$T3},[$Ktbl], #16
        rev32	@X[0],@X[0]		// yes, even on
        rev32	@X[1],@X[1]		// big-endian
        rev32	@X[2],@X[2]
        rev32	@X[3],@X[3]
        mov	$Xfer,sp
        add.32	$T0,$T0,@X[0]
        add.32	$T1,$T1,@X[1]
        add.32	$T2,$T2,@X[2]
        st1.32	{$T0-$T1},[$Xfer], #32
        add.32	$T3,$T3,@X[3]
        st1.32	{$T2-$T3},[$Xfer]
        sub	$Xfer,$Xfer,#32
        ldp	$A,$B,[$ctx]
        ldp	$C,$D,[$ctx,#8]
        ldp	$E,$F,[$ctx,#16]
        ldp	$G,$H,[$ctx,#24]
        ldr	$t1,[sp,#0]
        mov	$t2,wzr
        eor	$t3,$B,$C
        mov	$t4,wzr
        b	.L_00_48
    .align	4
    .L_00_48:
    ___
        &Xupdate(\&body_00_15);
        &Xupdate(\&body_00_15);
        &Xupdate(\&body_00_15);
        &Xupdate(\&body_00_15);
    $code.=<<___;
        cmp	$t1,#0				// check for K256 terminator
        ldr	$t1,[sp,#0]
        sub	$Xfer,$Xfer,#64
        bne	.L_00_48
        sub	$Ktbl,$Ktbl,#256		// rewind $Ktbl
        cmp	$inp,$num
        mov	$Xfer, #64
        csel	$Xfer, $Xfer, xzr, eq
        sub	$inp,$inp,$Xfer			// avoid SEGV
        mov	$Xfer,sp
    ___
        &Xpreload(\&body_00_15);
        &Xpreload(\&body_00_15);
        &Xpreload(\&body_00_15);
        &Xpreload(\&body_00_15);
    $code.=<<___;
        add	$A,$A,$t4			// h+=Sigma0(a) from the past
        ldp	$t0,$t1,[$ctx,#0]
        add	$A,$A,$t2			// h+=Maj(a,b,c) from the past
        ldp	$t2,$t3,[$ctx,#8]
        add	$A,$A,$t0			// accumulate
        add	$B,$B,$t1
        ldp	$t0,$t1,[$ctx,#16]
        add	$C,$C,$t2
        add	$D,$D,$t3
        ldp	$t2,$t3,[$ctx,#24]
        add	$E,$E,$t0
        add	$F,$F,$t1
        ldr	$t1,[sp,#0]
        stp	$A,$B,[$ctx,#0]
        add	$G,$G,$t2
        mov	$t2,wzr
        stp	$C,$D,[$ctx,#8]
        add	$H,$H,$t3
        stp	$E,$F,[$ctx,#16]
        eor	$t3,$B,$C
        stp	$G,$H,[$ctx,#24]
        mov	$t4,wzr
        mov	$Xfer,sp
        b.ne	.L_00_48
        ldr	x29,[x29]
        add	sp,sp,#16*4+16
        ret
    .size	sha256_block_neon,.-sha256_block_neon

ARMv8 sha256 [#sha256_block_data_order_armv8_sha256]_

.. code-block:: objdump

    .type	sha256_block_armv8,%function
    .align	6
    sha256_block_armv8:
    .Lv8_entry:
        stp		x29,x30,[sp,#-16]!
        add		x29,sp,#0
        ld1.32		{$ABCD,$EFGH},[$ctx]
        adr		$Ktbl,.LK256
    .Loop_hw:
        ld1		{@MSG[0]-@MSG[3]},[$inp],#64
        sub		$num,$num,#1
        ld1.32		{$W0},[$Ktbl],#16
        rev32		@MSG[0],@MSG[0]
        rev32		@MSG[1],@MSG[1]
        rev32		@MSG[2],@MSG[2]
        rev32		@MSG[3],@MSG[3]
        orr		$ABCD_SAVE,$ABCD,$ABCD		// offload
        orr		$EFGH_SAVE,$EFGH,$EFGH
    ___
    for($i=0;$i<12;$i++) {
    $code.=<<___;
        ld1.32		{$W1},[$Ktbl],#16
        add.i32		$W0,$W0,@MSG[0]
        sha256su0	@MSG[0],@MSG[1]
        orr		$abcd,$ABCD,$ABCD
        sha256h		$ABCD,$EFGH,$W0
        sha256h2	$EFGH,$abcd,$W0
        sha256su1	@MSG[0],@MSG[2],@MSG[3]
    ___
        ($W0,$W1)=($W1,$W0);	push(@MSG,shift(@MSG));
    }
    $code.=<<___;
        ld1.32		{$W1},[$Ktbl],#16
        add.i32		$W0,$W0,@MSG[0]
        orr		$abcd,$ABCD,$ABCD
        sha256h		$ABCD,$EFGH,$W0
        sha256h2	$EFGH,$abcd,$W0
        ld1.32		{$W0},[$Ktbl],#16
        add.i32		$W1,$W1,@MSG[1]
        orr		$abcd,$ABCD,$ABCD
        sha256h		$ABCD,$EFGH,$W1
        sha256h2	$EFGH,$abcd,$W1
        ld1.32		{$W1},[$Ktbl]
        add.i32		$W0,$W0,@MSG[2]
        sub		$Ktbl,$Ktbl,#$rounds*$SZ-16	// rewind
        orr		$abcd,$ABCD,$ABCD
        sha256h		$ABCD,$EFGH,$W0
        sha256h2	$EFGH,$abcd,$W0
        add.i32		$W1,$W1,@MSG[3]
        orr		$abcd,$ABCD,$ABCD
        sha256h		$ABCD,$EFGH,$W1
        sha256h2	$EFGH,$abcd,$W1
        add.i32		$ABCD,$ABCD,$ABCD_SAVE
        add.i32		$EFGH,$EFGH,$EFGH_SAVE
        cbnz		$num,.Loop_hw
        st1.32		{$ABCD,$EFGH},[$ctx]
        ldr		x29,[sp],#16
        ret
    .size	sha256_block_armv8,.-sha256_block_armv8


.. [#crypto] https://itbilu.com/tools/crypto/sha1.html
.. [#sha256online] https://emn178.github.io/online-tools/sha256.html
.. [#sha256] https://github.com/openssl/openssl/blob/914f97eecc9166fbfdb50c2d04e2b9f9d0c52198/include/openssl/sha.h#L71
.. [#sha256_call] https://github.com/openssl/openssl/blob/914f97eecc9166fbfdb50c2d04e2b9f9d0c52198/crypto/sha/sha256.c#L70
.. [#sha256_block_data_order] https://github.com/openssl/openssl/blob/914f97eecc9166fbfdb50c2d04e2b9f9d0c52198/crypto/sha/sha256.c#L253
.. [#sha256_block_data_order_neon_sha256] https://github.com/openssl/openssl/blob/914f97eecc9166fbfdb50c2d04e2b9f9d0c52198/crypto/sha/asm/sha512-armv8.pl#L629
.. [#sha256_block_data_order_armv8_sha256] https://github.com/openssl/openssl/blob/914f97eecc9166fbfdb50c2d04e2b9f9d0c52198/crypto/sha/asm/sha512-armv8.pl#L368

0000000000400a1c <main>:
  400a1c:       a9b77bfd        stp     x29, x30, [sp,#-144]!
  400a20:       910003fd        mov     x29, sp
  400a24:       52800020        mov     w0, #0x1                        // #1
  400a28:       390103a0        strb    w0, [x29,#64]
  400a2c:       52800040        mov     w0, #0x2                        // #2
  400a30:       390107a0        strb    w0, [x29,#65]
  400a34:       52800060        mov     w0, #0x3                        // #3
  400a38:       39010ba0        strb    w0, [x29,#66]
  400a3c:       52800080        mov     w0, #0x4                        // #4
  400a40:       39010fa0        strb    w0, [x29,#67]
  400a44:       528000a0        mov     w0, #0x5                        // #5
  400a48:       390113a0        strb    w0, [x29,#68]
  400a4c:       528000c0        mov     w0, #0x6                        // #6
  400a50:       390117a0        strb    w0, [x29,#69]
  400a54:       528000e0        mov     w0, #0x7                        // #7
  400a58:       39011ba0        strb    w0, [x29,#70]
  400a5c:       52800100        mov     w0, #0x8                        // #8
  400a60:       39011fa0        strb    w0, [x29,#71]
  400a64:       52800120        mov     w0, #0x9                        // #9
  400a68:       390123a0        strb    w0, [x29,#72]
  400a6c:       52800140        mov     w0, #0xa                        // #10
  400a70:       390127a0        strb    w0, [x29,#73]
  400a74:       52800160        mov     w0, #0xb                        // #11
  400a78:       39012ba0        strb    w0, [x29,#74]
  400a7c:       52800180        mov     w0, #0xc                        // #12
  400a80:       39012fa0        strb    w0, [x29,#75]
  400a84:       528001a0        mov     w0, #0xd                        // #13
  400a88:       390133a0        strb    w0, [x29,#76]
  400a8c:       528001c0        mov     w0, #0xe                        // #14
  400a90:       390137a0        strb    w0, [x29,#77]
  400a94:       528001e0        mov     w0, #0xf                        // #15
  400a98:       39013ba0        strb    w0, [x29,#78]
  400a9c:       52800200        mov     w0, #0x10                       // #16
  400aa0:       39013fa0        strb    w0, [x29,#79]
  400aa4:       910103a0        add     x0, x29, #0x40
  400aa8:       f90047a0        str     x0, [x29,#136]
  400aac:       f94047a0        ldr     x0, [x29,#136]
  400ab0:       4c407000        ld1     {v0.16b}, [x0]
  400ab4:       4e083c00        mov     x0, v0.d[0]
  400ab8:       4e183c01        mov     x1, v0.d[1]
  400abc:       aa0103e2        mov     x2, x1
  400ac0:       aa0003e1        mov     x1, x0
  400ac4:       9100c3a0        add     x0, x29, #0x30
  400ac8:       4e081c21        mov     v1.d[0], x1
  400acc:       4e181c41        mov     v1.d[1], x2
  400ad0:       4c007001        st1     {v1.16b}, [x0]
  400ad4:       52800060        mov     w0, #0x3                        // #3
  400ad8:       b90087a0        str     w0, [x29,#132]
  400adc:       b94087a0        ldr     w0, [x29,#132]
  400ae0:       4e010c00        dup     v0.16b, w0
  400ae4:       4e083c01        mov     x1, v0.d[0]
  400ae8:       4e183c02        mov     x2, v0.d[1]
  400aec:       9101c3a0        add     x0, x29, #0x70
  400af0:       4e081c21        mov     v1.d[0], x1
  400af4:       4e181c41        mov     v1.d[1], x2
  400af8:       4c007001        st1     {v1.16b}, [x0]
  400afc:       9101c3a0        add     x0, x29, #0x70
  400b00:       4c407000        ld1     {v0.16b}, [x0]
  400b04:       4e083c00        mov     x0, v0.d[0]
  400b08:       4e183c01        mov     x1, v0.d[1]
  400b0c:       aa0103e2        mov     x2, x1
  400b10:       aa0003e1        mov     x1, x0
  400b14:       910083a0        add     x0, x29, #0x20
  400b18:       4e081c21        mov     v1.d[0], x1
  400b1c:       4e181c41        mov     v1.d[1], x2
  400b20:       4c007001        st1     {v1.16b}, [x0]
  400b24:       9100c3a0        add     x0, x29, #0x30
  400b28:       4c407000        ld1     {v0.16b}, [x0]
  400b2c:       4e083c03        mov     x3, v0.d[0]
  400b30:       4e183c04        mov     x4, v0.d[1]
  400b34:       910083a0        add     x0, x29, #0x20
  400b38:       4c407001        ld1     {v1.16b}, [x0]
  400b3c:       4e083c21        mov     x1, v1.d[0]
  400b40:       4e183c22        mov     x2, v1.d[1]
  400b44:       910183a0        add     x0, x29, #0x60
  400b48:       4e081c60        mov     v0.d[0], x3
  400b4c:       4e181c80        mov     v0.d[1], x4
  400b50:       4c007000        st1     {v0.16b}, [x0]
  400b54:       910143a0        add     x0, x29, #0x50
  400b58:       4e081c21        mov     v1.d[0], x1
  400b5c:       4e181c41        mov     v1.d[1], x2
  400b60:       4c007001        st1     {v1.16b}, [x0]
  400b64:       910183a1        add     x1, x29, #0x60
  400b68:       910143a0        add     x0, x29, #0x50
  400b6c:       4c407020        ld1     {v0.16b}, [x1]
  400b70:       4e083c02        mov     x2, v0.d[0]
  400b74:       4e183c03        mov     x3, v0.d[1]
  400b78:       4c407001        ld1     {v1.16b}, [x0]
  400b7c:       4e083c20        mov     x0, v1.d[0]
  400b80:       4e183c21        mov     x1, v1.d[1]
  400b84:       4e081c40        mov     v0.d[0], x2
  400b88:       4e181c60        mov     v0.d[1], x3
  400b8c:       4e081c01        mov     v1.d[0], x0
  400b90:       4e181c21        mov     v1.d[1], x1
  400b94:       4e218400        add     v0.16b, v0.16b, v1.16b
  400b98:       4e083c00        mov     x0, v0.d[0]
  400b9c:       4e183c01        mov     x1, v0.d[1]
  400ba0:       aa0103e2        mov     x2, x1
  400ba4:       aa0003e1        mov     x1, x0
  400ba8:       910043a0        add     x0, x29, #0x10
  400bac:       4e081c20        mov     v0.d[0], x1
  400bb0:       4e181c40        mov     v0.d[1], x2
  400bb4:       4c007000        st1     {v0.16b}, [x0]
  400bb8:       9100c3a0        add     x0, x29, #0x30
  400bbc:       52800201        mov     w1, #0x10                       // #16
  400bc0:       97ffff7c        bl      4009b0 <print_uint8x16>
  400bc4:       910083a0        add     x0, x29, #0x20
  400bc8:       52800201        mov     w1, #0x10                       // #16
  400bcc:       97ffff79        bl      4009b0 <print_uint8x16>
  400bd0:       910043a0        add     x0, x29, #0x10
  400bd4:       52800201        mov     w1, #0x10                       // #16
  400bd8:       97ffff76        bl      4009b0 <print_uint8x16>
  400bdc:       a8c97bfd        ldp     x29, x30, [sp],#144
  400be0:       d65f03c0        ret

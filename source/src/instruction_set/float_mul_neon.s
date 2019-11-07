	.arch armv8.2-a+crc
	.file	"float_mul_neon.c"
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"%d\n"
	.text
	.align	2
	.global	mul_int
	.type	mul_int, %function
mul_int:
.LFB3827:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	str	w1, [sp, 24]
	ldr	w1, [sp, 28]
	ldr	w0, [sp, 24]
	mul	w0, w1, w0
	str	w0, [sp, 44]
	ldr	w1, [sp, 44]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3827:
	.size	mul_int, .-mul_int
	.section	.rodata
	.align	3
.LC1:
	.string	"%ld\n"
	.text
	.align	2
	.global	mul_long
	.type	mul_long, %function
mul_long:
.LFB3828:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	x0, [sp, 24]
	str	x1, [sp, 16]
	ldr	x1, [sp, 24]
	ldr	x0, [sp, 16]
	mul	x0, x1, x0
	str	x0, [sp, 40]
	ldr	x1, [sp, 40]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3828:
	.size	mul_long, .-mul_long
	.section	.rodata
	.align	3
.LC2:
	.string	"%lf\n"
	.text
	.align	2
	.global	mul_double
	.type	mul_double, %function
mul_double:
.LFB3829:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	d0, [sp, 24]
	str	d1, [sp, 16]
	ldr	d1, [sp, 24]
	ldr	d0, [sp, 16]
	fmul	d0, d1, d0
	str	d0, [sp, 40]
	ldr	d0, [sp, 40]
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	bl	printf
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3829:
	.size	mul_double, .-mul_double
	.global	__multf3
	.align	2
	.global	mul_long_double
	.type	mul_long_double, %function
mul_long_double:
.LFB3830:
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	mov	x29, sp
	str	q0, [sp, 32]
	str	q1, [sp, 16]
	ldr	q1, [sp, 16]
	ldr	q0, [sp, 32]
	bl	__multf3
	str	q0, [sp, 48]
	ldr	q0, [sp, 48]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	printf
	nop
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3830:
	.size	mul_long_double, .-mul_long_double
	.section	.rodata
	.align	3
.LC3:
	.string	"%u\n"
	.text
	.align	2
	.global	mul_uint32
	.type	mul_uint32, %function
mul_uint32:
.LFB3831:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	str	w1, [sp, 24]
	ldr	w1, [sp, 28]
	ldr	w0, [sp, 24]
	mul	w0, w1, w0
	str	w0, [sp, 44]
	ldr	w1, [sp, 44]
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3831:
	.size	mul_uint32, .-mul_uint32
	.section	.rodata
	.align	3
.LC4:
	.string	"%lu \n"
	.text
	.align	2
	.global	mul_uint64
	.type	mul_uint64, %function
mul_uint64:
.LFB3832:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	x0, [sp, 24]
	str	x1, [sp, 16]
	ldr	x1, [sp, 24]
	ldr	x0, [sp, 16]
	mul	x0, x1, x0
	str	x0, [sp, 40]
	ldr	x1, [sp, 40]
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	printf
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3832:
	.size	mul_uint64, .-mul_uint64
	.align	2
	.global	mul_float16
	.type	mul_float16, %function
mul_float16:
.LFB3833:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	h0, [sp, 30]
	str	h1, [sp, 28]
	ldr	h0, [sp, 30]
	fcvt	s1, h0
	ldr	h0, [sp, 28]
	fcvt	s0, h0
	fmul  v0.8h,  v0.8h, v1.8h
	fmul	s0, s1, s0
	fcvt	h0, s0
	str	h0, [sp, 46]
	ldr	h0, [sp, 46]
	fcvt	s0, h0
	fcvtzs	x0, s0
	str	x0, [sp, 32]
	ldr	x1, [sp, 32]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3833:
	.size	mul_float16, .-mul_float16
	.align	2
	.global	main
	.type	main, %function
main:
.LFB3834:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	mov	w1, 4
	mov	w0, 3
	bl	mul_int
	mov	x1, 3333
	mov	x0, 2222
	bl	mul_long
	adrp	x0, .LC5
	ldr	d1, [x0, #:lo12:.LC5]
	adrp	x0, .LC6
	ldr	d0, [x0, #:lo12:.LC6]
	bl	mul_double
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	ldr	q1, [x0]
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	ldr	q0, [x0]
	bl	mul_long_double
	mov	w1, 333
	mov	w0, 222
	bl	mul_uint32
	mov	x1, 333
	mov	x0, 222
	bl	mul_uint64
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE3834:
	.size	main, .-main
	.section	.rodata
	.align	3
.LC5:
	.word	4157528343
	.word	1081398611
	.align	3
.LC6:
	.word	2680059593
	.word	1080805146
	.align	4
.LC7:
	.word	0
	.word	1879048192
	.word	1065151889
	.word	1074220373
	.align	4
.LC8:
	.word	0
	.word	2415919104
	.word	2851858284
	.word	1074183281
	.ident	"GCC: (GNU) 8.3.1 20190311 (Red Hat 8.3.1-3)"
	.section	.note.GNU-stack,"",@progbits

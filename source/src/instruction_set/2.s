	.cpu generic+fp+simd
	.file	"float_mul.c"
	.section	.rodata
	.align	3
.LC0:
	.string	"%d\n"
	.text
	.align	2
	.global	mul_int
	.type	mul_int, %function
mul_int:
.LFB2:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	w0, [x29,28]
	str	w1, [x29,24]
	ldr	w1, [x29,28]
	ldr	w0, [x29,24]
	mul	w0, w1, w0
	str	w0, [x29,44]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	ldr	w1, [x29,44]
	bl	printf
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE2:
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
.LFB3:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29,24]
	str	x1, [x29,16]
	ldr	x1, [x29,24]
	ldr	x0, [x29,16]
	mul	x0, x1, x0
	str	x0, [x29,40]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	ldr	x1, [x29,40]
	bl	printf
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE3:
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
.LFB4:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	d0, [x29,24]
	str	d1, [x29,16]
	ldr	x1, [x29,24]
	ldr	x0, [x29,16]
	fmov	d0, x1
	fmov	d1, x0
	fmul	d0, d0, d1
	fmov	x0, d0
	str	x0, [x29,40]
	adrp	x0, .LC2
	add	x0, x0, :lo12:.LC2
	ldr	d0, [x29,40]
	bl	printf
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE4:
	.size	mul_double, .-mul_double
	.global	__multf3
	.align	2
	.global	mul_long_double
	.type	mul_long_double, %function
mul_long_double:
.LFB5:
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	q0, [x29,32]
	str	q1, [x29,16]
	ldr	q0, [x29,32]
	ldr	q1, [x29,16]
	bl	__multf3
	fmov	x0, d0
	fmov	x1, v0.d[1]
	stp	x0, x1, [x29,48]
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	ldr	q0, [x29,48]
	bl	printf
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5:
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
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	w0, [x29,28]
	str	w1, [x29,24]
	ldr	w1, [x29,28]
	ldr	w0, [x29,24]
	mul	w0, w1, w0
	str	w0, [x29,44]
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	ldr	w1, [x29,44]
	bl	printf
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE6:
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
.LFB7:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29,24]
	str	x1, [x29,16]
	ldr	x1, [x29,24]
	ldr	x0, [x29,16]
	mul	x0, x1, x0
	str	x0, [x29,40]
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	ldr	x1, [x29,40]
	bl	printf
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE7:
	.size	mul_uint64, .-mul_uint64
	.align	2
	.global	main
	.type	main, %function
main:
.LFB8:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	mov	w0, 3
	mov	w1, 4
	bl	mul_int
	mov	x0, 2222
	mov	x1, 3333
	bl	mul_long
	ldr	x1, .LC5
	ldr	x0, .LC6
	fmov	d0, x1
	fmov	d1, x0
	bl	mul_double
	ldr	q0, .LC7
	fmov	x2, d0
	fmov	x3, v0.d[1]
	ldr	q0, .LC8
	fmov	x0, d0
	fmov	x1, v0.d[1]
	fmov	d0, x2
	fmov	v0.d[1], x3
	fmov	d1, x0
	fmov	v1.d[1], x1
	bl	mul_long_double
	mov	w0, 222
	mov	w1, 333
	bl	mul_uint32
	mov	x0, 222
	mov	x1, 333
	bl	mul_uint64
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.align	3
.LC5:
	.word	2680059593
	.word	1080805146
	.align	3
.LC6:
	.word	4157528343
	.word	1081398611
	.align	4
.LC7:
	.word	0
	.word	2415919104
	.word	2851858284
	.word	1074183281
	.align	4
.LC8:
	.word	0
	.word	1879048192
	.word	1065151889
	.word	1074220373
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-36)"
	.section	.note.GNU-stack,"",%progbits

	.arch armv8-a
	.text
	.section	.rodata
.LC0:
	.string	"hello world %d\n"
	.text
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -32]!
	add	x29, sp, 0
	mov	w0, 6
	str	w0, [x29, 28]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	ldr	w1, [x29, 28]
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	ret
	.size	main, .-main


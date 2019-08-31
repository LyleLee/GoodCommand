	.arch armv8.2-a+crc+fp16
	.file	"fp16_g.cpp"
	.text
	.section	.rodata
	.align	3
	.type	_ZStL19piecewise_construct, %object
	.size	_ZStL19piecewise_construct, 1
_ZStL19piecewise_construct:
	.zero	1
	.text
	.align	2
	.global	_Z7my_randv
	.type	_Z7my_randv, %function
_Z7my_randv:
.LFB5032:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	bl	rand
	scvtf	d1, w0
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	ldr	d0, [x0]
	fdiv	d0, d1, d0
	fcvt	h0, d0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5032:
	.size	_Z7my_randv, .-_Z7my_randv
	.section	.rodata
	.align	3
.LC0:
	.word	4290772992
	.word	1105199103
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB5033:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5033
	stp	x29, x30, [sp, -272]!
	.cfi_def_cfa_offset 272
	.cfi_offset 29, -272
	.cfi_offset 30, -264
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x19, [sp, 16]
	.cfi_offset 19, -256
	mov	w0, 11
	bl	srand
	mov	w0, 800
	str	w0, [x29, 260]
	ldrsw	x19, [x29, 260]
	add	x0, x29, 104
	bl	_ZNSaIDhEC1Ev
	add	x1, x29, 104
	add	x0, x29, 80
	mov	x2, x1
	mov	x1, x19
.LEHB0:
	bl	_ZNSt6vectorIDhSaIDhEEC1EmRKS0_
.LEHE0:
	add	x0, x29, 104
	bl	_ZNSaIDhED1Ev
	ldrsw	x19, [x29, 260]
	add	x0, x29, 112
	bl	_ZNSaIDhEC1Ev
	add	x1, x29, 112
	add	x0, x29, 56
	mov	x2, x1
	mov	x1, x19
.LEHB1:
	bl	_ZNSt6vectorIDhSaIDhEEC1EmRKS0_
.LEHE1:
	add	x0, x29, 112
	bl	_ZNSaIDhED1Ev
	ldrsw	x19, [x29, 260]
	add	x0, x29, 120
	bl	_ZNSaIDhEC1Ev
	add	x1, x29, 120
	add	x0, x29, 32
	mov	x2, x1
	mov	x1, x19
.LEHB2:
	bl	_ZNSt6vectorIDhSaIDhEEC1EmRKS0_
.LEHE2:
	add	x0, x29, 120
	bl	_ZNSaIDhED1Ev
	add	x0, x29, 80
	bl	_ZNSt6vectorIDhSaIDhEE5beginEv
	mov	x19, x0
	add	x0, x29, 80
	bl	_ZNSt6vectorIDhSaIDhEE3endEv
	mov	x1, x0
	adrp	x0, _Z7my_randv
	add	x0, x0, :lo12:_Z7my_randv
	mov	x2, x0
	mov	x0, x19
.LEHB3:
	bl	_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_
	add	x0, x29, 56
	bl	_ZNSt6vectorIDhSaIDhEE5beginEv
	mov	x19, x0
	add	x0, x29, 56
	bl	_ZNSt6vectorIDhSaIDhEE3endEv
	mov	x1, x0
	adrp	x0, _Z7my_randv
	add	x0, x0, :lo12:_Z7my_randv
	mov	x2, x0
	mov	x0, x19
	bl	_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_
.LEHE3:
	str	xzr, [x29, 264]
.L8:
	ldrsw	x0, [x29, 260]
	ldr	x1, [x29, 264]
	cmp	x1, x0
	bcs	.L4
	add	x0, x29, 80
	ldr	x1, [x29, 264]
	bl	_ZNSt6vectorIDhSaIDhEEixEm
	str	x0, [x29, 200]
	ldr	x0, [x29, 200]
	ldr	q0, [x0]
	str	q0, [x29, 240]
	add	x0, x29, 56
	ldr	x1, [x29, 264]
	bl	_ZNSt6vectorIDhSaIDhEEixEm
	str	x0, [x29, 192]
	ldr	x0, [x29, 192]
	ldr	q0, [x0]
	str	q0, [x29, 224]
	ldr	q0, [x29, 240]
	str	q0, [x29, 144]
	ldr	q0, [x29, 224]
	str	q0, [x29, 128]
	ldr	q1, [x29, 144]
	ldr	q0, [x29, 128]
	fmul	v0.8h, v1.8h, v0.8h
	str	q0, [x29, 208]
	add	x0, x29, 32
	ldr	x1, [x29, 264]
	bl	_ZNSt6vectorIDhSaIDhEEixEm
	str	x0, [x29, 184]
	ldr	q0, [x29, 208]
	str	q0, [x29, 160]
	ldr	x0, [x29, 184]
	ldr	q0, [x29, 160]
	str	q0, [x0]
	ldr	x0, [x29, 264]
	add	x0, x0, 8
	str	x0, [x29, 264]
	b	.L8
.L4:
	mov	w19, 0
	add	x0, x29, 32
	bl	_ZNSt6vectorIDhSaIDhEED1Ev
	add	x0, x29, 56
	bl	_ZNSt6vectorIDhSaIDhEED1Ev
	add	x0, x29, 80
	bl	_ZNSt6vectorIDhSaIDhEED1Ev
	mov	w0, w19
	b	.L20
.L16:
	mov	x19, x0
	add	x0, x29, 104
	bl	_ZNSaIDhED1Ev
	mov	x0, x19
.LEHB4:
	bl	_Unwind_Resume
.L17:
	mov	x19, x0
	add	x0, x29, 112
	bl	_ZNSaIDhED1Ev
	b	.L12
.L18:
	mov	x19, x0
	add	x0, x29, 120
	bl	_ZNSaIDhED1Ev
	b	.L14
.L19:
	mov	x19, x0
	add	x0, x29, 32
	bl	_ZNSt6vectorIDhSaIDhEED1Ev
.L14:
	add	x0, x29, 56
	bl	_ZNSt6vectorIDhSaIDhEED1Ev
.L12:
	add	x0, x29, 80
	bl	_ZNSt6vectorIDhSaIDhEED1Ev
	mov	x0, x19
	bl	_Unwind_Resume
.LEHE4:
.L20:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 272
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5033:
	.global	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA5033:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE5033-.LLSDACSB5033
.LLSDACSB5033:
	.uleb128 .LEHB0-.LFB5033
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L16-.LFB5033
	.uleb128 0
	.uleb128 .LEHB1-.LFB5033
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L17-.LFB5033
	.uleb128 0
	.uleb128 .LEHB2-.LFB5033
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L18-.LFB5033
	.uleb128 0
	.uleb128 .LEHB3-.LFB5033
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L19-.LFB5033
	.uleb128 0
	.uleb128 .LEHB4-.LFB5033
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSE5033:
	.text
	.size	main, .-main
	.section	.text._ZNSaIDhEC2Ev,"axG",@progbits,_ZNSaIDhEC5Ev,comdat
	.align	2
	.weak	_ZNSaIDhEC2Ev
	.type	_ZNSaIDhEC2Ev, %function
_ZNSaIDhEC2Ev:
.LFB5038:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	ldr	x0, [x29, 24]
	bl	_ZN9__gnu_cxx13new_allocatorIDhEC2Ev
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5038:
	.size	_ZNSaIDhEC2Ev, .-_ZNSaIDhEC2Ev
	.weak	_ZNSaIDhEC1Ev
	.set	_ZNSaIDhEC1Ev,_ZNSaIDhEC2Ev
	.section	.text._ZNSaIDhED2Ev,"axG",@progbits,_ZNSaIDhED5Ev,comdat
	.align	2
	.weak	_ZNSaIDhED2Ev
	.type	_ZNSaIDhED2Ev, %function
_ZNSaIDhED2Ev:
.LFB5041:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	ldr	x0, [x29, 24]
	bl	_ZN9__gnu_cxx13new_allocatorIDhED2Ev
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5041:
	.size	_ZNSaIDhED2Ev, .-_ZNSaIDhED2Ev
	.weak	_ZNSaIDhED1Ev
	.set	_ZNSaIDhED1Ev,_ZNSaIDhED2Ev
	.section	.text._ZNSt6vectorIDhSaIDhEEC2EmRKS0_,"axG",@progbits,_ZNSt6vectorIDhSaIDhEEC5EmRKS0_,comdat
	.align	2
	.weak	_ZNSt6vectorIDhSaIDhEEC2EmRKS0_
	.type	_ZNSt6vectorIDhSaIDhEEC2EmRKS0_, %function
_ZNSt6vectorIDhSaIDhEEC2EmRKS0_:
.LFB5044:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5044
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x19, [sp, 16]
	.cfi_offset 19, -48
	str	x0, [x29, 56]
	str	x1, [x29, 48]
	str	x2, [x29, 40]
	ldr	x0, [x29, 56]
	ldr	x2, [x29, 40]
	ldr	x1, [x29, 48]
.LEHB5:
	bl	_ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_
.LEHE5:
	ldr	x1, [x29, 48]
	ldr	x0, [x29, 56]
.LEHB6:
	bl	_ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm
.LEHE6:
	b	.L26
.L25:
	mov	x19, x0
	ldr	x0, [x29, 56]
	bl	_ZNSt12_Vector_baseIDhSaIDhEED2Ev
	mov	x0, x19
.LEHB7:
	bl	_Unwind_Resume
.LEHE7:
.L26:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5044:
	.section	.gcc_except_table
.LLSDA5044:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE5044-.LLSDACSB5044
.LLSDACSB5044:
	.uleb128 .LEHB5-.LFB5044
	.uleb128 .LEHE5-.LEHB5
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB6-.LFB5044
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L25-.LFB5044
	.uleb128 0
	.uleb128 .LEHB7-.LFB5044
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
.LLSDACSE5044:
	.section	.text._ZNSt6vectorIDhSaIDhEEC2EmRKS0_,"axG",@progbits,_ZNSt6vectorIDhSaIDhEEC5EmRKS0_,comdat
	.size	_ZNSt6vectorIDhSaIDhEEC2EmRKS0_, .-_ZNSt6vectorIDhSaIDhEEC2EmRKS0_
	.weak	_ZNSt6vectorIDhSaIDhEEC1EmRKS0_
	.set	_ZNSt6vectorIDhSaIDhEEC1EmRKS0_,_ZNSt6vectorIDhSaIDhEEC2EmRKS0_
	.section	.text._ZNSt6vectorIDhSaIDhEED2Ev,"axG",@progbits,_ZNSt6vectorIDhSaIDhEED5Ev,comdat
	.align	2
	.weak	_ZNSt6vectorIDhSaIDhEED2Ev
	.type	_ZNSt6vectorIDhSaIDhEED2Ev, %function
_ZNSt6vectorIDhSaIDhEED2Ev:
.LFB5047:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5047
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	stp	x19, x20, [sp, 16]
	.cfi_offset 19, -32
	.cfi_offset 20, -24
	str	x0, [x29, 40]
	ldr	x0, [x29, 40]
	ldr	x19, [x0]
	ldr	x0, [x29, 40]
	ldr	x20, [x0, 8]
	ldr	x0, [x29, 40]
	bl	_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv
	mov	x2, x0
	mov	x1, x20
	mov	x0, x19
	bl	_ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E
	ldr	x0, [x29, 40]
	bl	_ZNSt12_Vector_baseIDhSaIDhEED2Ev
	nop
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5047:
	.section	.gcc_except_table
.LLSDA5047:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE5047-.LLSDACSB5047
.LLSDACSB5047:
.LLSDACSE5047:
	.section	.text._ZNSt6vectorIDhSaIDhEED2Ev,"axG",@progbits,_ZNSt6vectorIDhSaIDhEED5Ev,comdat
	.size	_ZNSt6vectorIDhSaIDhEED2Ev, .-_ZNSt6vectorIDhSaIDhEED2Ev
	.weak	_ZNSt6vectorIDhSaIDhEED1Ev
	.set	_ZNSt6vectorIDhSaIDhEED1Ev,_ZNSt6vectorIDhSaIDhEED2Ev
	.section	.text._ZNSt6vectorIDhSaIDhEE5beginEv,"axG",@progbits,_ZNSt6vectorIDhSaIDhEE5beginEv,comdat
	.align	2
	.weak	_ZNSt6vectorIDhSaIDhEE5beginEv
	.type	_ZNSt6vectorIDhSaIDhEE5beginEv, %function
_ZNSt6vectorIDhSaIDhEE5beginEv:
.LFB5049:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	ldr	x1, [x29, 24]
	add	x0, x29, 40
	bl	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC1ERKS1_
	ldr	x0, [x29, 40]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5049:
	.size	_ZNSt6vectorIDhSaIDhEE5beginEv, .-_ZNSt6vectorIDhSaIDhEE5beginEv
	.section	.text._ZNSt6vectorIDhSaIDhEE3endEv,"axG",@progbits,_ZNSt6vectorIDhSaIDhEE3endEv,comdat
	.align	2
	.weak	_ZNSt6vectorIDhSaIDhEE3endEv
	.type	_ZNSt6vectorIDhSaIDhEE3endEv, %function
_ZNSt6vectorIDhSaIDhEE3endEv:
.LFB5050:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	ldr	x0, [x29, 24]
	add	x1, x0, 8
	add	x0, x29, 40
	bl	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC1ERKS1_
	ldr	x0, [x29, 40]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5050:
	.size	_ZNSt6vectorIDhSaIDhEE3endEv, .-_ZNSt6vectorIDhSaIDhEE3endEv
	.section	.text._ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_,"axG",@progbits,_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_,comdat
	.align	2
	.weak	_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_
	.type	_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_, %function
_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_:
.LFB5051:
	.cfi_startproc
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x19, [sp, 16]
	.cfi_offset 19, -48
	str	x0, [x29, 56]
	str	x1, [x29, 48]
	str	x2, [x29, 40]
.L34:
	add	x1, x29, 48
	add	x0, x29, 56
	bl	_ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_
	and	w0, w0, 255
	cmp	w0, 0
	beq	.L35
	add	x0, x29, 56
	bl	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv
	mov	x19, x0
	ldr	x0, [x29, 40]
	blr	x0
	str	h0, [x19]
	add	x0, x29, 56
	bl	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv
	b	.L34
.L35:
	nop
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5051:
	.size	_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_, .-_ZSt8generateIN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEEPFDhvEEvT_S9_T0_
	.section	.text._ZNSt6vectorIDhSaIDhEEixEm,"axG",@progbits,_ZNSt6vectorIDhSaIDhEEixEm,comdat
	.align	2
	.weak	_ZNSt6vectorIDhSaIDhEEixEm
	.type	_ZNSt6vectorIDhSaIDhEEixEm, %function
_ZNSt6vectorIDhSaIDhEEixEm:
.LFB5052:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	str	x1, [sp]
	ldr	x0, [sp, 8]
	ldr	x1, [x0]
	ldr	x0, [sp]
	lsl	x0, x0, 1
	add	x0, x1, x0
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5052:
	.size	_ZNSt6vectorIDhSaIDhEEixEm, .-_ZNSt6vectorIDhSaIDhEEixEm
	.section	.text._ZN9__gnu_cxx13new_allocatorIDhEC2Ev,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorIDhEC5Ev,comdat
	.align	2
	.weak	_ZN9__gnu_cxx13new_allocatorIDhEC2Ev
	.type	_ZN9__gnu_cxx13new_allocatorIDhEC2Ev, %function
_ZN9__gnu_cxx13new_allocatorIDhEC2Ev:
.LFB5056:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5056:
	.size	_ZN9__gnu_cxx13new_allocatorIDhEC2Ev, .-_ZN9__gnu_cxx13new_allocatorIDhEC2Ev
	.weak	_ZN9__gnu_cxx13new_allocatorIDhEC1Ev
	.set	_ZN9__gnu_cxx13new_allocatorIDhEC1Ev,_ZN9__gnu_cxx13new_allocatorIDhEC2Ev
	.section	.text._ZN9__gnu_cxx13new_allocatorIDhED2Ev,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorIDhED5Ev,comdat
	.align	2
	.weak	_ZN9__gnu_cxx13new_allocatorIDhED2Ev
	.type	_ZN9__gnu_cxx13new_allocatorIDhED2Ev, %function
_ZN9__gnu_cxx13new_allocatorIDhED2Ev:
.LFB5059:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5059:
	.size	_ZN9__gnu_cxx13new_allocatorIDhED2Ev, .-_ZN9__gnu_cxx13new_allocatorIDhED2Ev
	.weak	_ZN9__gnu_cxx13new_allocatorIDhED1Ev
	.set	_ZN9__gnu_cxx13new_allocatorIDhED1Ev,_ZN9__gnu_cxx13new_allocatorIDhED2Ev
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD2Ev,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD5Ev,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD2Ev
	.type	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD2Ev, %function
_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD2Ev:
.LFB5063:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	ldr	x0, [x29, 24]
	bl	_ZNSaIDhED2Ev
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5063:
	.size	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD2Ev, .-_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD2Ev
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD1Ev
	.set	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD1Ev,_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD2Ev
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEEC5EmRKS0_,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_
	.type	_ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_, %function
_ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_:
.LFB5065:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5065
	stp	x29, x30, [sp, -64]!
	.cfi_def_cfa_offset 64
	.cfi_offset 29, -64
	.cfi_offset 30, -56
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x19, [sp, 16]
	.cfi_offset 19, -48
	str	x0, [x29, 56]
	str	x1, [x29, 48]
	str	x2, [x29, 40]
	ldr	x0, [x29, 56]
	ldr	x1, [x29, 40]
	bl	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC1ERKS0_
	ldr	x1, [x29, 48]
	ldr	x0, [x29, 56]
.LEHB8:
	bl	_ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm
.LEHE8:
	b	.L44
.L43:
	mov	x19, x0
	ldr	x0, [x29, 56]
	bl	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD1Ev
	mov	x0, x19
.LEHB9:
	bl	_Unwind_Resume
.LEHE9:
.L44:
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 64
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5065:
	.section	.gcc_except_table
.LLSDA5065:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE5065-.LLSDACSB5065
.LLSDACSB5065:
	.uleb128 .LEHB8-.LFB5065
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L43-.LFB5065
	.uleb128 0
	.uleb128 .LEHB9-.LFB5065
	.uleb128 .LEHE9-.LEHB9
	.uleb128 0
	.uleb128 0
.LLSDACSE5065:
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEEC5EmRKS0_,comdat
	.size	_ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_, .-_ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_
	.weak	_ZNSt12_Vector_baseIDhSaIDhEEC1EmRKS0_
	.set	_ZNSt12_Vector_baseIDhSaIDhEEC1EmRKS0_,_ZNSt12_Vector_baseIDhSaIDhEEC2EmRKS0_
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEED2Ev,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEED5Ev,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEED2Ev
	.type	_ZNSt12_Vector_baseIDhSaIDhEED2Ev, %function
_ZNSt12_Vector_baseIDhSaIDhEED2Ev:
.LFB5068:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA5068
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	ldr	x0, [x29, 24]
	ldr	x1, [x0]
	ldr	x0, [x29, 24]
	ldr	x0, [x0, 16]
	mov	x2, x0
	ldr	x0, [x29, 24]
	ldr	x0, [x0]
	sub	x0, x2, x0
	asr	x0, x0, 1
	mov	x2, x0
	ldr	x0, [x29, 24]
	bl	_ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm
	ldr	x0, [x29, 24]
	bl	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implD1Ev
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5068:
	.section	.gcc_except_table
.LLSDA5068:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE5068-.LLSDACSB5068
.LLSDACSB5068:
.LLSDACSE5068:
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEED2Ev,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEED5Ev,comdat
	.size	_ZNSt12_Vector_baseIDhSaIDhEED2Ev, .-_ZNSt12_Vector_baseIDhSaIDhEED2Ev
	.weak	_ZNSt12_Vector_baseIDhSaIDhEED1Ev
	.set	_ZNSt12_Vector_baseIDhSaIDhEED1Ev,_ZNSt12_Vector_baseIDhSaIDhEED2Ev
	.section	.text._ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm,"axG",@progbits,_ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm,comdat
	.align	2
	.weak	_ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm
	.type	_ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm, %function
_ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm:
.LFB5070:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x19, [sp, 16]
	.cfi_offset 19, -32
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	ldr	x0, [x29, 40]
	ldr	x19, [x0]
	ldr	x0, [x29, 40]
	bl	_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv
	mov	x2, x0
	ldr	x1, [x29, 32]
	mov	x0, x19
	bl	_ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E
	mov	x1, x0
	ldr	x0, [x29, 40]
	str	x1, [x0, 8]
	nop
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5070:
	.size	_ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm, .-_ZNSt6vectorIDhSaIDhEE21_M_default_initializeEm
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv
	.type	_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv, %function
_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv:
.LFB5071:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	ldr	x0, [sp, 8]
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5071:
	.size	_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv, .-_ZNSt12_Vector_baseIDhSaIDhEE19_M_get_Tp_allocatorEv
	.section	.text._ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E,"axG",@progbits,_ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E,comdat
	.align	2
	.weak	_ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E
	.type	_ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E, %function
_ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E:
.LFB5072:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	str	x2, [x29, 24]
	ldr	x1, [x29, 32]
	ldr	x0, [x29, 40]
	bl	_ZSt8_DestroyIPDhEvT_S1_
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5072:
	.size	_ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E, .-_ZSt8_DestroyIPDhDhEvT_S1_RSaIT0_E
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC2ERKS1_,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC5ERKS1_,comdat
	.align	2
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC2ERKS1_
	.type	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC2ERKS1_, %function
_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC2ERKS1_:
.LFB5074:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	str	x1, [sp]
	ldr	x0, [sp]
	ldr	x1, [x0]
	ldr	x0, [sp, 8]
	str	x1, [x0]
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5074:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC2ERKS1_, .-_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC2ERKS1_
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC1ERKS1_
	.set	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC1ERKS1_,_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEC2ERKS1_
	.section	.text._ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_,"axG",@progbits,_ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_,comdat
	.align	2
	.weak	_ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_
	.type	_ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_, %function
_ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_:
.LFB5076:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x19, [sp, 16]
	.cfi_offset 19, -32
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	ldr	x0, [x29, 40]
	bl	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv
	ldr	x19, [x0]
	ldr	x0, [x29, 32]
	bl	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv
	ldr	x0, [x0]
	cmp	x19, x0
	cset	w0, ne
	and	w0, w0, 255
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5076:
	.size	_ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_, .-_ZN9__gnu_cxxneIPDhSt6vectorIDhSaIDhEEEEbRKNS_17__normal_iteratorIT_T0_EESA_
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv,comdat
	.align	2
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv
	.type	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv, %function
_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv:
.LFB5077:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	ldr	x0, [sp, 8]
	ldr	x0, [x0]
	add	x1, x0, 2
	ldr	x0, [sp, 8]
	str	x1, [x0]
	ldr	x0, [sp, 8]
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5077:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv, .-_ZN9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEppEv
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv,comdat
	.align	2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv, %function
_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv:
.LFB5078:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	ldr	x0, [sp, 8]
	ldr	x0, [x0]
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5078:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEEdeEv
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC2ERKS0_,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC5ERKS0_,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC2ERKS0_
	.type	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC2ERKS0_, %function
_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC2ERKS0_:
.LFB5080:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	ldr	x1, [x29, 16]
	ldr	x0, [x29, 24]
	bl	_ZNSaIDhEC2ERKS_
	ldr	x0, [x29, 24]
	str	xzr, [x0]
	ldr	x0, [x29, 24]
	str	xzr, [x0, 8]
	ldr	x0, [x29, 24]
	str	xzr, [x0, 16]
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5080:
	.size	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC2ERKS0_, .-_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC2ERKS0_
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC1ERKS0_
	.set	_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC1ERKS0_,_ZNSt12_Vector_baseIDhSaIDhEE12_Vector_implC2ERKS0_
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm
	.type	_ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm, %function
_ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm:
.LFB5082:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	ldr	x1, [x29, 16]
	ldr	x0, [x29, 24]
	bl	_ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm
	mov	x1, x0
	ldr	x0, [x29, 24]
	str	x1, [x0]
	ldr	x0, [x29, 24]
	ldr	x1, [x0]
	ldr	x0, [x29, 24]
	str	x1, [x0, 8]
	ldr	x0, [x29, 24]
	ldr	x1, [x0]
	ldr	x0, [x29, 16]
	lsl	x0, x0, 1
	add	x1, x1, x0
	ldr	x0, [x29, 24]
	str	x1, [x0, 16]
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5082:
	.size	_ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm, .-_ZNSt12_Vector_baseIDhSaIDhEE17_M_create_storageEm
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm
	.type	_ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm, %function
_ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm:
.LFB5083:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	str	x2, [x29, 24]
	ldr	x0, [x29, 32]
	cmp	x0, 0
	beq	.L61
	ldr	x0, [x29, 40]
	ldr	x2, [x29, 24]
	ldr	x1, [x29, 32]
	bl	_ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm
.L61:
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5083:
	.size	_ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm, .-_ZNSt12_Vector_baseIDhSaIDhEE13_M_deallocateEPDhm
	.section	.text._ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E,"axG",@progbits,_ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E,comdat
	.align	2
	.weak	_ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E
	.type	_ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E, %function
_ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E:
.LFB5084:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	str	x2, [x29, 24]
	ldr	x1, [x29, 32]
	ldr	x0, [x29, 40]
	bl	_ZSt25__uninitialized_default_nIPDhmET_S1_T0_
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5084:
	.size	_ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E, .-_ZSt27__uninitialized_default_n_aIPDhmDhET_S1_T0_RSaIT1_E
	.section	.text._ZSt8_DestroyIPDhEvT_S1_,"axG",@progbits,_ZSt8_DestroyIPDhEvT_S1_,comdat
	.align	2
	.weak	_ZSt8_DestroyIPDhEvT_S1_
	.type	_ZSt8_DestroyIPDhEvT_S1_, %function
_ZSt8_DestroyIPDhEvT_S1_:
.LFB5085:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	ldr	x1, [x29, 16]
	ldr	x0, [x29, 24]
	bl	_ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5085:
	.size	_ZSt8_DestroyIPDhEvT_S1_, .-_ZSt8_DestroyIPDhEvT_S1_
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv,comdat
	.align	2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv, %function
_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv:
.LFB5086:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	ldr	x0, [sp, 8]
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5086:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPDhSt6vectorIDhSaIDhEEE4baseEv
	.section	.text._ZNSaIDhEC2ERKS_,"axG",@progbits,_ZNSaIDhEC5ERKS_,comdat
	.align	2
	.weak	_ZNSaIDhEC2ERKS_
	.type	_ZNSaIDhEC2ERKS_, %function
_ZNSaIDhEC2ERKS_:
.LFB5088:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	ldr	x1, [x29, 16]
	ldr	x0, [x29, 24]
	bl	_ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_
	nop
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5088:
	.size	_ZNSaIDhEC2ERKS_, .-_ZNSaIDhEC2ERKS_
	.weak	_ZNSaIDhEC1ERKS_
	.set	_ZNSaIDhEC1ERKS_,_ZNSaIDhEC2ERKS_
	.section	.text._ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm,"axG",@progbits,_ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm,comdat
	.align	2
	.weak	_ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm
	.type	_ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm, %function
_ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm:
.LFB5090:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	ldr	x0, [x29, 16]
	cmp	x0, 0
	beq	.L69
	ldr	x0, [x29, 24]
	ldr	x1, [x29, 16]
	bl	_ZNSt16allocator_traitsISaIDhEE8allocateERS0_m
	b	.L71
.L69:
	mov	x0, 0
.L71:
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5090:
	.size	_ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm, .-_ZNSt12_Vector_baseIDhSaIDhEE11_M_allocateEm
	.section	.text._ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm,"axG",@progbits,_ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm,comdat
	.align	2
	.weak	_ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm
	.type	_ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm, %function
_ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm:
.LFB5091:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	str	x2, [x29, 24]
	ldr	x2, [x29, 24]
	ldr	x1, [x29, 32]
	ldr	x0, [x29, 40]
	bl	_ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5091:
	.size	_ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm, .-_ZNSt16allocator_traitsISaIDhEE10deallocateERS0_PDhm
	.section	.text._ZSt25__uninitialized_default_nIPDhmET_S1_T0_,"axG",@progbits,_ZSt25__uninitialized_default_nIPDhmET_S1_T0_,comdat
	.align	2
	.weak	_ZSt25__uninitialized_default_nIPDhmET_S1_T0_
	.type	_ZSt25__uninitialized_default_nIPDhmET_S1_T0_, %function
_ZSt25__uninitialized_default_nIPDhmET_S1_T0_:
.LFB5092:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	mov	w0, 1
	strb	w0, [x29, 47]
	ldr	x1, [x29, 16]
	ldr	x0, [x29, 24]
	bl	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5092:
	.size	_ZSt25__uninitialized_default_nIPDhmET_S1_T0_, .-_ZSt25__uninitialized_default_nIPDhmET_S1_T0_
	.section	.text._ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_,"axG",@progbits,_ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_,comdat
	.align	2
	.weak	_ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_
	.type	_ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_, %function
_ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_:
.LFB5093:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	str	x1, [sp]
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5093:
	.size	_ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_, .-_ZNSt12_Destroy_auxILb1EE9__destroyIPDhEEvT_S3_
	.section	.text._ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorIDhEC5ERKS1_,comdat
	.align	2
	.weak	_ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_
	.type	_ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_, %function
_ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_:
.LFB5095:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	str	x1, [sp]
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5095:
	.size	_ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_, .-_ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_
	.weak	_ZN9__gnu_cxx13new_allocatorIDhEC1ERKS1_
	.set	_ZN9__gnu_cxx13new_allocatorIDhEC1ERKS1_,_ZN9__gnu_cxx13new_allocatorIDhEC2ERKS1_
	.section	.text._ZNSt16allocator_traitsISaIDhEE8allocateERS0_m,"axG",@progbits,_ZNSt16allocator_traitsISaIDhEE8allocateERS0_m,comdat
	.align	2
	.weak	_ZNSt16allocator_traitsISaIDhEE8allocateERS0_m
	.type	_ZNSt16allocator_traitsISaIDhEE8allocateERS0_m, %function
_ZNSt16allocator_traitsISaIDhEE8allocateERS0_m:
.LFB5097:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	mov	x2, 0
	ldr	x1, [x29, 16]
	ldr	x0, [x29, 24]
	bl	_ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5097:
	.size	_ZNSt16allocator_traitsISaIDhEE8allocateERS0_m, .-_ZNSt16allocator_traitsISaIDhEE8allocateERS0_m
	.section	.text._ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm,comdat
	.align	2
	.weak	_ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm
	.type	_ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm, %function
_ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm:
.LFB5098:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	str	x2, [x29, 24]
	ldr	x0, [x29, 32]
	bl	_ZdlPv
	nop
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5098:
	.size	_ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm, .-_ZN9__gnu_cxx13new_allocatorIDhE10deallocateEPDhm
	.section	.text._ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_,"axG",@progbits,_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_,comdat
	.align	2
	.weak	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_
	.type	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_, %function
_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_:
.LFB5099:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 24]
	str	x1, [x29, 16]
	strh	wzr, [x29, 46]
	add	x0, x29, 46
	mov	x2, x0
	ldr	x1, [x29, 16]
	ldr	x0, [x29, 24]
	bl	_ZSt6fill_nIPDhmDhET_S1_T0_RKT1_
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5099:
	.size	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_, .-_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPDhmEET_S3_T0_
	.section	.text._ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv,"axG",@progbits,_ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv,comdat
	.align	2
	.weak	_ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv
	.type	_ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv, %function
_ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv:
.LFB5100:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	str	x2, [x29, 24]
	ldr	x0, [x29, 40]
	bl	_ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv
	mov	x1, x0
	ldr	x0, [x29, 32]
	cmp	x0, x1
	cset	w0, hi
	and	w0, w0, 255
	cmp	w0, 0
	beq	.L83
	bl	_ZSt17__throw_bad_allocv
.L83:
	ldr	x0, [x29, 32]
	lsl	x0, x0, 1
	bl	_Znwm
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5100:
	.size	_ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv, .-_ZN9__gnu_cxx13new_allocatorIDhE8allocateEmPKv
	.section	.text._ZSt6fill_nIPDhmDhET_S1_T0_RKT1_,"axG",@progbits,_ZSt6fill_nIPDhmDhET_S1_T0_RKT1_,comdat
	.align	2
	.weak	_ZSt6fill_nIPDhmDhET_S1_T0_RKT1_
	.type	_ZSt6fill_nIPDhmDhET_S1_T0_RKT1_, %function
_ZSt6fill_nIPDhmDhET_S1_T0_RKT1_:
.LFB5101:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	add	x29, sp, 0
	.cfi_def_cfa_register 29
	str	x0, [x29, 40]
	str	x1, [x29, 32]
	str	x2, [x29, 24]
	ldr	x0, [x29, 40]
	bl	_ZSt12__niter_baseIPDhET_S1_
	ldr	x2, [x29, 24]
	ldr	x1, [x29, 32]
	bl	_ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa 31, 0
	ret
	.cfi_endproc
.LFE5101:
	.size	_ZSt6fill_nIPDhmDhET_S1_T0_RKT1_, .-_ZSt6fill_nIPDhmDhET_S1_T0_RKT1_
	.section	.text._ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv,"axG",@progbits,_ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv,comdat
	.align	2
	.weak	_ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv
	.type	_ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv, %function
_ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv:
.LFB5102:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	mov	x0, 9223372036854775807
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5102:
	.size	_ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv, .-_ZNK9__gnu_cxx13new_allocatorIDhE8max_sizeEv
	.section	.text._ZSt12__niter_baseIPDhET_S1_,"axG",@progbits,_ZSt12__niter_baseIPDhET_S1_,comdat
	.align	2
	.weak	_ZSt12__niter_baseIPDhET_S1_
	.type	_ZSt12__niter_baseIPDhET_S1_, %function
_ZSt12__niter_baseIPDhET_S1_:
.LFB5103:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, 8]
	ldr	x0, [sp, 8]
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5103:
	.size	_ZSt12__niter_baseIPDhET_S1_, .-_ZSt12__niter_baseIPDhET_S1_
	.section	.text._ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_,"axG",@progbits,_ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_,comdat
	.align	2
	.weak	_ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_
	.type	_ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_, %function
_ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_:
.LFB5104:
	.cfi_startproc
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	str	x0, [sp, 24]
	str	x1, [sp, 16]
	str	x2, [sp, 8]
	ldr	x0, [sp, 16]
	str	x0, [sp, 40]
.L93:
	ldr	x0, [sp, 40]
	cmp	x0, 0
	beq	.L92
	ldr	x0, [sp, 8]
	ldr	h0, [x0]
	ldr	x0, [sp, 24]
	str	h0, [x0]
	ldr	x0, [sp, 40]
	sub	x0, x0, #1
	str	x0, [sp, 40]
	ldr	x0, [sp, 24]
	add	x0, x0, 2
	str	x0, [sp, 24]
	b	.L93
.L92:
	ldr	x0, [sp, 24]
	add	sp, sp, 48
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE5104:
	.size	_ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_, .-_ZSt10__fill_n_aIPDhmDhEN9__gnu_cxx11__enable_ifIXntsrSt11__is_scalarIT1_E7__valueET_E6__typeES6_T0_RKS4_
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align	3
	.type	DW.ref.__gxx_personality_v0, %object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.xword	__gxx_personality_v0
	.ident	"GCC: (GNU) 7.3.1 20180303 (Red Hat 7.3.1-5)"
	.section	.note.GNU-stack,"",@progbits

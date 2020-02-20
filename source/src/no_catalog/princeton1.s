.section .data
length: .word 1
width: .word 2
perim: .word 0
.section .text
.global main
main:
adr x0, length
ldr w1, [x0]
adr x0, width
ldr w2, [x0]
add w1, w1, w2
lsl w1, w1, 1
adr x0, perim
str w1, [x0]
mov w0, 0
ret


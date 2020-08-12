*************************
ARM 汇编
*************************

简单aarch64汇编编程介绍 [#princeton]_

data段


.. sidebar:: 汇编

    .. code-block:: objdump

                    .section ".data"
                    c:
                    .byte 'a'
                    s:
                    .short 12
                    i:
                    .word 345
                    l:
                    .quad 6789

.. code-block:: c

        static char  c = 'a';
        static short s = 12;
        static int  i = 345;
        static long l = 6789;



::

    .section instruction (to announce DATA section)
    label definition (marks a spot in RAM)
    .byte instruction (1 byte)
    .short instruction (2 bytes)
    .word instruction (4 bytes)
    .quad instruction (8 bytes)


adr指令

.. list-table::
   :widths: 50,50

   *
        -  C语言
            .. code-block:: c

                static int length = 1;
                static int width = 2;
                static int perim = 0;
                int main()
                {
                    perim =(length + width) * 2;
                    return 0;
                }

        -  汇编
            .. code-block:: objdump

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

::

    .data: read-write
    .rodata: read-only
    .bss: read-write, initialized to zero
    .text: read-only, program code
    Stack and heap work differently!

.. [#princeton] https://www.cs.princeton.edu/courses/archive/spring19/cos217/lectures/13_Assembly1.pdf

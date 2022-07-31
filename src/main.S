    #include "matrix_simd_aarch64.h"
    .section rodata
    .text
    .global main
    .type	main, %function
main:
    stp     x29, x30, [sp, #-16]!
    ldp     x29, x30, [sp], #16
    mov     x0, #5
    mov     x1, #5
    bl      matrix_create
    mov     w0, #0
    ret
    .size   main, . - main
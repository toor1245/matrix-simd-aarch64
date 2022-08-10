    #include "matrix_simd_aarch64.h"

    .section rodata
    .text
    .global main
    .type	main, %function
main:
    stp     x19, x20, [sp, #-16]!
    stp     x29, x30, [sp, #-16]!
    mov     x0, #5
    mov     x1, #5
    mov     x2, #1
    bl      matrix_create
    bl      matrix_print_int
    mov     x19, x0
    mov     x0, #5
    mov     x1, #5
    mov     x2, #1
    bl      matrix_create
    bl      matrix_print_int
    mov     x20, x0
    mov     x0, x19
    mov     x1, x20
    bl      matrix_print_int
    bl      matrix_add_int
    bl      matrix_print_int
    mov     w0, #0
    ldp     x29, x30, [sp], #16
    stp     x19, x20, [sp], #16
    ret
    .size   main, . - main
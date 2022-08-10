        #include "matrix_simd_aarch64.h"

        .data
print_el:   .string "%d "
new_line:   .string "\n"
        .text
### --------------------------------------------------------
### x0 holds matrix pointer
    .global matrix_print_int
    .type   matrix_print_int, %function
matrix_print_int:
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!
    stp     x29, x30, [sp, #-16]!

    mov     x19, x0
    ldr     x20, [x19, #MATRIX_ARRAY_OFFSET]
    ldr     w21, [x19, #MATRIX_ROWS_OFFSET]
    ldr     w22, [x19, #MATRIX_COLUMNS_OFFSET]

    mov     x23, #0
1:  
    cmp     w21, w23
    beq     4f
    mov     x24, #0
2:
    cmp     w24, w22
    beq     3f
    adr     x0, print_el
    ldr     w1, [x20, x24, lsl #2] 
    bl      printf
    add     x24, x24, #1
    b       2b
3:
    adr     x0, new_line
    bl      printf
    add     x23, x23, #1
    b       1b
4:
    ldp     x29, x30, [sp], #16
    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ret
    .size   matrix_print_int, (. - matrix_print_int)

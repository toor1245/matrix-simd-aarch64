#include "matrix_simd_aarch64.h"

### --------------------------------------------------------
### x0 holds number of rows
### x1 holds number of columns
### x2 holds init value
    .global matrix_create
    .type   matrix_create, %function
matrix_create:
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!
    stp     x29, x30, [sp, #-16]!
    mov     x20, x0                            // rows
    mov     x21, x1                            // columns
    mov     x24, x2                            // init value
    mul     x22, x0, x1                        // length
    mov     x0, #MATRIX_SIZE
    bl      malloc
    mov     x23, x0                            // matrix_t 
    str     w20, [x23, #MATRIX_ROWS_OFFSET]
    str     w21, [x23, #MATRIX_COLUMNS_OFFSET]
    str     w22, [x23, #MATRIX_LENGTH_OFFSET]
    mov     x4, #4
    mul     x0, x22, x4
    bl      malloc                             // array = malloc(rows * column)
    str     x0, [x23, #MATRIX_ARRAY_OFFSET]
    mov     x1, #0
1:  
    cmp     w1, w22
    beq     2f
    str     w24, [x0, x1, lsl #2]
    add     x1, x1, #1
    b       1b
2:
    mov     x0, x23
    ldp	    x29, x30, [sp], #16
    ldp	    x23, x24, [sp], #16
    ldp	    x21, x22, [sp], #16
    ldp	    x19, x20, [sp], #16
    ret
    .size   matrix_create, (. - matrix_create)

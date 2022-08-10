#include "matrix_simd_aarch64.h"

### ------------------------------------------------------
### x0 holds matrixA pointer
### x1 holds matrixB pointer
    .global matrix_add_int
    .type   matrix_add_int, %function
matrix_add_int:
    stp     x19, x20, [sp, #-16]
    stp     x29, x30, [sp, #-16]
    mov     x19, x0
    mov     x20, x1

    // matrixA.rows == matrixB.rows
    ldr     w0, [x19, #MATRIX_ROWS_OFFSET]
    ldr     w1, [x20, #MATRIX_ROWS_OFFSET]
    cmp     w0, w1
    bne     2f

    // matrixA.columns == matrixB.columns
    ldr     w1, [x19, #MATRIX_COLUMNS_OFFSET]
    ldr     w2, [x20, #MATRIX_COLUMNS_OFFSET]
    cmp     w1, w2
    bne     2f

    mul     x5, x0, x1                        // x5 = rows * columns
    bl      matrix_create
    ldr     x1,  [x0,  #MATRIX_ARRAY_OFFSET]  // x1 = matrixC.array
    ldr     x9,  [x19, #MATRIX_ARRAY_OFFSET]  // x9  = matrixA.array
    ldr     x10, [x20, #MATRIX_ARRAY_OFFSET]  // x10 = matrixB.array
    mov     x6, #0
1:
    cmp     x6, x5
    beq     3f
    ldr     w11, [x9,  x6, lsl #2]
    ldr     w12, [x10, x6, lsl #2]
    add     w13, w11, w12
    str     w13, [x1,  x6, lsl #2]
    b       1b
2:  
    mov     x0, xzr
3:
    ldp     x29, x30, [sp], #16
    ldp     x19, x20, [sp], #16
    ret
    .size   matrix_add_int, (. - matrix_add_int)

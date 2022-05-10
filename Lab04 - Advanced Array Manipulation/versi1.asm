.data 
array: .byte 127, 1, 42, 56, 57, 13, 12, 13, 41, 15, 12

.text
.globl main

main: 
     la $t0, array # Memasukkan array ke t0
     
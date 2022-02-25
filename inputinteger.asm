.data 

.text
.globl main
main:

    li $v0, 5
    syscall
    
    add $t0, $v0, $zero
    
    li $v0, 1
    add $a0, $t0, $zero
    syscall
    
    li $v0, 10
    syscall
.data
myString: .asciiz "Hello World"

.text 
.globl main
main:
    li $v0, 4
    la $a0, myString
    syscall
    
    li $v0, 10
    syscall
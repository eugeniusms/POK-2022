# nama : eugenius mario situmorang
# npm : 2106750484
# kelas : pok b
.data
# Inisiasi semua format output display
infantri: .asciiz "Masukkan jumlah infantri: "
tank: .asciiz "Masukkan jumlah tank: "
pesawat: .asciiz "Masukkan jumlah pesawat tempur: "
output: .asciiz "\nTotal biaya yang dikeluarkan adalah $"

.text 
.globl main
main: 
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, infantri # register a0 = infantri
    syscall # execute
    
    li $v0, 5 # syscall 5 = load instruction read integer
    syscall # execute
    
    add $t0, $v0, $zero # t0 digunakan untuk jumlah infantri
    
    ################################################
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, tank # register a0 = tank
    syscall # execute
    
    li $v0, 5 # syscall 5 = load instruction read integer
    syscall # execute
    
    add $t1, $v0, $zero # t1 digunakan untuk jumlah tank
    
    ################################################
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, pesawat # register a0 = pesawat
    syscall # execute
    
    li $v0, 5 # syscall 5 = load instruction read integer
    syscall # execute
    
    add $t2, $v0, $zero # t2 digunakan untuk jumlah pesawat
    
    ################################################
    		# Total Harga Masing-Masing #
    ################################################
    addi $t5, $zero, 100 # t5 untuk harga infantri
    addi $t6, $zero, 1500 # t6 untuk harga infantri
    addi $t7, $zero, 3000 # t7 untuk harga infantri
    
    mul $t5, $t0, $t5 # harga total infantri 
    mul $t6, $t1, $t6 # harga total tank
    mul $t7, $t2, $t7 # harga total pesawat
    
    j proses # ke proses

proses:
    add $t3, $t1, $t2 # t3 dipakai untuk jumlah tank dan pesawat
    slt $t4, $t0, $t3 # t4 dipakai untuk hasil least than if infantri < tank + pesawat
    bne $t4, $zero, tankpesawat  # saat tank + pesawat > infantri maka ke tankpesawat
    
    # saat tidak maka lanjutkan output semua harga total
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, output # register a0 = output
    syscall # execute
    
    # hitung total harga
    # s3 untuk total harga
    add $t0, $t5, $t6 # harga infantri + tank
    add $t0, $t0, $t7 # + pesawat
    
    li $v0, 1 # syscall 1 = print integer harga infantri tank dan pesawat
    la $a0, ($t0)  # register t0 = total harga infantri tank dan pesawat
    syscall # execute
    
    j exit
    
tankpesawat:
    # totalkan harga tank dan pesawat saja
    add $t0, $t6, $t7 # total harga tank dan pesawat
    
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, output # register a0 = output
    syscall # execute
    
    li $v0, 1 # syscall 1 = print integer harga tank dan pesawat
    la $a0, ($t0)  # register t0 = total harga tank dan pesawat
    syscall # execute
    
    j exit
    
exit:
    li $v0, 10 # syscall 10 = exit program
    syscall # execute
    
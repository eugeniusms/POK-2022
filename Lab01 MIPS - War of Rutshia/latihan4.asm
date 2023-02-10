# nama : eugenius mario situmorang
# npm : 2106750484
# kelas : pok b
.data
# Inisiasi semua format output display
infantri: .asciiz "Masukkan jumlah infantri: "
tank: .asciiz "Masukkan jumlah tank: "
pesawat: .asciiz "Masukkan jumlah pesawat tempur: "
batalion: .asciiz "Masukkan jumlah batalion yang ingin dibentuk: "
output: .asciiz "\nMasing-masing batalion berisikan "

 #i Inisiasi formatting akhir (hasil)
isi1: .asciiz " infantri, "
isi2: .asciiz " tank, dan "
isi3: .asciiz " pesawat tempur."


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
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, batalion # register a0 = batalion
    syscall # execute
    
    li $v0, 5 # syscall 5 = load instruction read integer
    syscall # execute
    
    add $t3, $v0, $zero # t3 digunakan untuk jumlah batalion
    
    ################################################
    		      # VALIDASI #
    ################################################
    beq $t3, $zero, main # saat batalion 0 maka balik ke main
    
    # t4 untuk menyimpan hasil slt
    slt $t4, $t0, $t3 # saat batalion > infantri kembali ke main
    bne $t4, $zero, main
    
    slt $t4, $t1, $t3 # saat batalion > tank kembali ke main
    bne $t4, $zero, main
    
    slt $t4, $t2, $t3 # saat batalion > pesawat kembali ke main
    bne $t4, $zero, main

hasil:
    div $t0, $t3 # infantri div batalion 
    mflo $t5 # simpan ke t5
    
    div $t1, $t3 # infantri div batalion 
    mflo $t6 # simpan ke t6
    
    div $t2, $t3 # infantri div batalion 
    mflo $t7 # simpan ke t7

    # STRING FORMATTING OUTPUT
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, output # register a0 = output
    syscall # execute
    
    li $v0, 1 # syscall 1 = print integer hasil infantri div batalion
    la $a0, ($t5)  # register t5
    syscall # execute
    
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, isi1 # register a0 = isi1
    syscall # execute 
    
    li $v0, 1 # syscall 1 = print integer hasil tank div batalion
    la $a0, ($t6)  # register t6
    syscall # execute
    
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, isi2 # register a0 = isi2
    syscall # execute
    
    li $v0, 1 # syscall 1 = print integer hasil pesawat div batalion
    la $a0, ($t7)  # register t7
    syscall # execute
    
    li $v0, 4 # syscall 4 = print string register a0
    la $a0, isi3 # register a0 = isi3
    syscall # execute
    
    j exit # exit program
    
exit:
    li $v0, 10 # syscall 10 = exit program
    syscall # execute
    
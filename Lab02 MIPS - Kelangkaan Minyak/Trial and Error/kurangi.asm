 .data
# Inisiasi tampilan layar
input: .asciiz "Masukkan Input 10 digit:"
spasi: .asciiz "-"
# Inisiasi array yang akan digunakan menampung digit
array: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text 
.globl main
main: 
      la $t0, array # Mengisiasi input array ke $t0
 
      li $v0, 4 # syscall 4 = print string in register a0
      la $a0, input # register a0 = print isi input
      syscall # execute
   
      li $v0, 5 # syscall 5 = load instruction read integer
      syscall # execute
      
      add $t1, $v0, $zero # t1 digunakan untuk menyimpan masukan
      addi $t2, $zero, 0 # t2 digunakan sebagai counter
      j input_loop
      
input_loop: 
      div $t1, $t1, 10 # membagi masukan dengan 10
      mflo $t1 # hasil bagi disimpan ke t1 lagi
      mfhi $t4 # sisa bagi disimpan ke t4
      
      sb $t4, 0 ($t0) # masukkan sisa bagi ke t0
      addi $t0, $t0, 4 # memindahkan pointer ke indeks selanjutnya
      addi $t2, $t2, 1 # counting loop
      bne $t2, 10, input_loop # selama counter belum sampai 10 maka diloop lagi
      
      subi $t0, $t0, 40 # set pointer ke 0 lagi 
      j output
      
output:
     addi $t0, $t0, 4 # mengurangi indeks pointer ke indeks sebelumnya
     li $v0, 1 # print integer
     lb $a0, 0 ($t0) # mengambil isi dari array
     syscall # execute
     addi $s6, $a0, 0 # menyimpan a0 sementara
    
     # selanjutnya
     subi $t0, $t0, 4
     li $v0, 1 
     lb $a0, 0 ($t0)
     syscall
     addi $s7, $a0, 0 # menyimpan a0 sementara
     
     # set ulang pointer
     addi $t0, $t0, 4
     
     # formatting
     li $v0, 4 # syscall 4 = print string in register a0
     la $a0, spasi # register a0 = print isi input
     syscall # execute
     
     
     addi $s0, $s0, 1 # menambah counter
     bne $s0, 9, output # loop lagi sampai nol
     j exit
          
exit:
    li $v0, 10 # exit program
    syscall # execute
      

 .data
# Inisiasi tampilan layar
input: .asciiz "Masukkan Input 10 digit:"
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
      
      j input_loop # memulai pengambilan input
      
input_loop: 
      div $t1, $t1, 10 # membagi masukan dengan 10
      mflo $t1 # hasil bagi disimpan ke t1 lagi
      mfhi $t4 # sisa bagi disimpan ke t4
      
      sb $t4, 0 ($t0) # masukkan sisa bagi ke t0
      addi $t0, $t0, 4 # memindahkan pointer ke indeks selanjutnya
      addi $t2, $t2, 1 # counting loop
      bne $t2, 10, input_loop # selama counter belum sampai 10 maka diloop lagi
      
      subi $t0, $t0, 40 # set pointer ke 0 lagi 
      
      j output # memulai operasi dan mencetak output
      
output:
     # keterangan penyimpanan register
     # -> s6 untuk index before
     # -> s7 untuk index after
      
     # load index before
     addi $t0, $t0, 4 # menambah indeks pointer ke indeks setelahnya
     lb $a0, 0 ($t0) # mengambil isi dari array
     addi $s6, $a0, 0 # menyimpan a0 sementara
    
     # load index after
     subi $t0, $t0, 4 # mengurangi indeks pointer ke indeks sebelumnya
     lb $a0, 0 ($t0) # mengambil isi array
     addi $s7, $a0, 0 # menyimpan a0 sementara
     
     # set ulang pointer
     addi $t0, $t0, 4
    
     # mendapat selisih -> nilai absolute pengurangan a > b -> (a - b) || a < b -> (b - a)
     # cek s7 > s6
     slt $s4, $s6, $s7
     # if true s4 = 1
     beq $s4, 1, kurangiA
     # if false s4 = 0
     beq $s4, 0, kurangiB

kurangiA:
     # agar hasil kurang tetap positif (absolut)
     # hasil kurang
     sub $s5, $s7, $s6
     addi $s0, $s0, 1 # menambah counter
     
     # cetak
     li $v0, 1 # print integer
     la $a0, ($s5) # load integer
     syscall # execute
     
     bne $s0, 9, output # loop lagi sampai nol
     
     j exit # saat array sudah habis (counter ke 0)
     
kurangiB:
     # agar hasil kurang tetap positif (absolut)
     # hasil kurang
     sub $s5, $s6, $s7
     addi $s0, $s0, 1 # menambah counter
     
     # cetak
     li $v0, 1 # print integer
     la $a0, ($s5) # load integer
     syscall # execute
     
     bne $s0, 9, output # loop lagi sampai nol
     
     j exit # saat array sudah habis (counter ke 0)

exit:
     li $v0, 10 # exit program
     syscall # execute
      

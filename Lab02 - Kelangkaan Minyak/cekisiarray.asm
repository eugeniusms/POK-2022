 .data
# Inisiasi tampilan layar
input: .asciiz "Masukkan Input 10 digit:"
# Inisiasi array yang akan digunakan menampung digit
array: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arrayCopy9Akhir: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
arrayCopy9Awal: .word 0, 0, 0, 0, 0, 0, 0, 0, 0

.text 
.globl main
main: 
      la $t0, array # Mengisiasi input array ke $t0
      la $t5, arrayCopy9Awal #  Menginisiasi array 9awal
      la $t6, arrayCopy9Akhir # Menginisiasi array 9akhir
      
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
      
      j operateArrayCopy
	
operateArrayCopy:
     # load array
     subi $t0, $t0, 4 # mengurangi indeks pointer ke indeks sebelumnya
     lb $a0, 0 ($t0) # mengambil isi dari array
     
     # arrayAwal
     # saat counter 10 jangan masukkan isi arraynya
     bne $t2, 10, arrayAwal
     
     # arrayAkhir
     # saat counter 0 jangan masukkan isi arraynya
     bne $t2, 0, arrayAkhir
     
     subi $t2, $t2, 1 # mengurangi counter
     
     subi $t2, $t2, 1 # mengurangi counter
     bne $t2, 0, operateArrayCopy # loop lagi sampai nol
     j proses
     
arrayAwal:
     sb $a0, 0 ($t5) # memasukkan isi a0 ke t5
     addi $t5, $t5, 4 # memindahkan pointer ke indeks selanjutnya

arrayAkhir:
     sb $a0, 0 ($t6) # memasukkan isi a0 ke t6
     addi $t6, $t6, 4 # memindahkan pointer ke indeks selanjutnya
     
proses:
     # memulai pengurangan arrayAkhir - arrayAwal sesuai indeks dari belakang
     # menyetel pointer ke paling belakang 0 = isi ke 1, maka 4*8 = 32 (isi ke 9) + 4 agar perulangan lancar
     addi $t6, $t6, 36 # mendapat pointer terakhir arrayAkhir
     addi $t5, $t5, 36 # mendapat pointer terakhir arrayAwal
     
     # inisiasi counter
     addi $t7, $zero, 9
     
     j loopPengurangan
     
loopPengurangan:
     subi $t6, $t6, 4 # mengurangi pointer 
     lb $a0, 0 ($t6) # mengambil data arrayAkhir pointer ke s0
     subi $t5, $t5, 4 # mengurangi pointer
     lb $a1, 0 ($t5) # mengambil data arrayAwal pointer ke s1
     
     sub $t3, $a0, $a1 # mengurangi data indeks pointer arrayAkhir - arrayAwal
     
     # mencetak ke layar hasil dari pengurangannya
     li $v0, 1 # print integer
     la $a0, ($t3) # mengambil data hasil pengurangan
     syscall # execute
     
     subi $t7, $t7, 1 # mengurangi counter
     bne $t7, 0, loopPengurangan # ulangi sampai data habis
     
     addi $s0, $zero, 0 # count program
     
     j output
     
output:
     subi $t5, $t5, 4 # mengurangi indeks pointer ke indeks sebelumnya
     li $v0, 1 # print integer
     la $a0, 0 ($t5) # mengambil isi dari array
     syscall # execute
     
     addi $s0, $s0, 1 # menambah counter
     bne $s0, 9, output # loop lagi sampai nol
     j exit
          
exit:
    li $v0, 10 # exit program
    syscall # execute
      



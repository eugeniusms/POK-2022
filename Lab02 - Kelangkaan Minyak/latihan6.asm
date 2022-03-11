.data
# Inisiasi tampilan layar
input: .asciiz "Masukkan Input 10 digit:"
spasi: .asciiz "-\n"
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
      
      addi $t7, $zero, 0 # t7 digunakan sebagai counter array terpotong
      
      j input_loop
      
input_loop: 
      div $t1, $t1, 10 # membagi masukan dengan 10
      mflo $t1 # hasil bagi disimpan ke t1 lagi
      mfhi $t4 # sisa bagi disimpan ke t4
      
      sb $t4, 0 ($t0) # masukkan sisa bagi ke t0
      addi $t0, $t0, 4 # memindahkan pointer ke indeks selanjutnya
      addi $t2, $t2, 1 # counting loop
      bne $t2, 10, input_loop # selama counter belum sampai 10 maka diloop lagi
	
operateArrayCopy:
     # load array
     subi $t0, $t0, 4 # mengurangi indeks pointer ke indeks sebelumnya
     lb $s0, 0 ($t0) # mengambil isi dari array
     
     # arrayAwal
     # saat counter 10 jangan masukkan isi arraynya
     bne $t2, 10, arrayAwal
     
     # arrayAkhir
     # saat counter 0 jangan masukkan isi arraynya
     bne $t2, 0, arrayAkhir
     
     subi $t2, $t2, 1 # mengurangi counter
     
     subi $t2, $t2, 1 # mengurangi counter
     bne $t2, 0, operateArrayCopy # loop lagi sampai nol
     j loopPengurangan
     
arrayAwal:
     sb $s0, 0 ($t5) # memasukkan isi a0 ke t5
     addi $t5, $t5, 4 # memindahkan pointer ke indeks selanjutnya

arrayAkhir:
     sb $s0, 0 ($t6) # memasukkan isi a0 ke t6
     addi $t6, $t6, 4 # memindahkan pointer ke indeks selanjutnya
     
loopPengurangan:
     bne $t7, 0, pointerAdder
     lb $a0, 0 ($t6) # mengambil data arrayAkhir pointer ke s0
     lb $a1, 0 ($t5) # mengambil data arrayAwal pointer ke s1
     
     sub $t3, $a0, $a1 # mengurangi data indeks pointer arrayAkhir - arrayAwal
     
     # mencetak ke layar hasil dari pengurangannya
     li $v0, 1 # print integer
     la $a0, ($t3) # mengambil data hasil pengurangan
     syscall # execute
     
     # CHECK : membatasi print
     li $v0, 4
     la $a0, spasi
     syscall
     
     subi $t7, $t7, 1 # mengurangi counter
     bne $t7, 0, loopPengurangan # ulangi sampai data habis
     
     j exit
     
pointerAdder:
     addi $t5, $t5, 4 # memindahkan pointer ke indeks selanjutnya
     addi $t6, $t6, 4 # memindahkan pointer ke indeks selanjutnya
     
exit:
    li $v0, 10 # exit program
    syscall # execute
      
     

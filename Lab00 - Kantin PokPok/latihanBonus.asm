# nama : eugenius mario situmorang
# npm : 2106750484
# kelas : pok b
.data
# Menginisiasikan isi selamat datang dan menu dalam variabel menu, menu1, menu2, menu3
menu: .asciiz "Selamat datang di Kantin Pokpok Tercinta :D\n1. Nasi Ayam Goreng  (Rp 25)\n2. Nasi Udang Goreng (Rp 30)\n3. Nasi Ikan Goreng  (Rp 15)\n(Note: Harga dalam ribuan)\nMasukkan jumlah pesanan: "
daftar: .asciiz "Daftar pesanan (Tuliskan dengan angka menu) :\n"
menu1: .asciiz "Anda memesan: Nasi Ayam Goreng\n"
menu2: .asciiz "Anda memesan: Nasi Udang Goreng\n"
menu3: .asciiz "Anda memesan: Nasi Ikan Goreng\n" 
menuInvalid: .asciiz "Masukkan Anda tidak valid\n" # Keluaran input tidak valid

# Menginisiasikan isi hasil akhir program
hasil1: .asciiz "Terdapat "
hasil2: .asciiz " pesanan tidak valid"
hasil3: .asciiz "\nTotal harga pesanan Anda (Dalam ribuan) : "

.text 
.globl main
main:
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu # register a0 = print isi menu
    syscall # execute
    
    li $v0, 5 # syscall 5 = load instruction read integer
    syscall # execute
    
    add $t4, $v0, $zero # t4 digunakan untuk menyimpan jumlah pesanan
    add $t5, $zero, $zero # t5 digunakan sebagai loop counter
    add $t6, $zero, $zero # t6 digunakan untuk menghitung input invalid
    add $t7, $zero, $zero # t7 digunakan untuk menghitung harga dibeli
    
    li $v0, 4 # syscall 4 = print string
    la $a0, daftar # print daftar
    syscall #execute
    
    j getInput
    
getInput:
    addi $t5, $t5, 1 # increment t5 sebagai loop counter

    li $v0, 5 # syscall 5 = load instruction read integer
    syscall # execute get integer
    
    add $t0, $v0, $zero # temp variabel untuk input ($t0)
    addi $t1, $zero, 1 # temp variabel isi = 1
    addi $t2, $zero, 2 # temp variabel isi = 2
    addi $t3, $zero, 3 # temp variabel isi = 3
    
    beq $t0, $t1, get1 # jika input == 1 pergi ke get1
    beq $t0, $t2, get2 # jika input == 2 pergi ke get2
    beq $t0, $t3, get3 # jika input == 3 pergi ke get3
    
    # Ketika input tidak memenuhi kondisi ketiga beq di atas, maka
    # program terus berlanjut (tidak akan jump exit di dalam label get)
    # lanjutannya ke sini (cetak menuInvalid)
    
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menuInvalid # register a0 = print menuInvalid
    syscall # execute
    addi $t6, $t6, 1 # ketika lewat sini -> input invalid +1

    bne $t5, $t4, getInput # while loop selama jumlah pesanan belum pas ke getInput
    
    j exit # exit program saat selesai

get1:
    addi $t7, $t7, 25
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu1 # register a0 = print isi menu1
    syscall # execute
    
    beq $t4, $t5, exit # ketika loop counter sudah sama dengan jumlah pesanan maka exit
    
    j getInput
    
get2:
    addi $t7, $t7, 30
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu2 # register a0 = print isi menu2
    syscall # execute
    
    beq $t4, $t5, exit # ketika loop counter sudah sama dengan jumlah pesanan maka exit
    
    j getInput
    
get3:
    addi $t7, $t7, 15
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu3 # register a0 = print isi menu3
    syscall # execute
    
    beq $t4, $t5, exit # ketika loop counter sudah sama dengan jumlah pesanan maka exit
    
    j getInput
    
exit:
    # Saat loop selesai maka jalankan tampilan berikut
    li $v0, 4 # syscall 4 : print string in register a0
    la $a0, hasil1 # print "Terdapat "
    syscall #execute
    
    li $v0, 1 # syscall 1 : print integer in register a0
    la $a0, ($t6) # print jumlah angka tidak valid
    syscall #execute
    
    li $v0, 4 # syscall 4 : print string in register a0
    la $a0, hasil2 # print " pesanan tidak valid"
    syscall #execute
    
    li $v0, 4 # syscall 4 : print string in register a0
    la $a0, hasil3 # print last sentence (hasil3) kalimat harga
    syscall #execute
    
    li $v0, 1 # syscall 1 : print integer in register a0
    la $a0, ($t7) # print jumlah harga dibeli
    syscall #execute

    li $v0, 10 # syscall 10 = exit program
    syscall # execute
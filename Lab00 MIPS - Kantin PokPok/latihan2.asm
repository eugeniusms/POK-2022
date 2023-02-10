# nama : eugenius mario situmorang
# npm : 2106750484
# kelas : pok b
.data
# Menginisiasikan isi selamat datang dan menu dalam variabel menu, menu1, menu2, menu3
menu: .asciiz "Selamat datang di Kantin Pokpok Tercinta :D\n1. Nasi Ayam Goreng  (Rp 25)\n2. Nasi Udang Goreng (Rp 30)\n3. Nasi Ikan Goreng  (Rp 15)\n(Note: Harga dalam ribuan)\nMasukkan pesanan Anda (tuliskan dengan angka menu): "
menu1: .asciiz "Anda memesan: Nasi Ayam Goreng"
menu2: .asciiz "Anda memesan: Nasi Udang Goreng"
menu3: .asciiz "Anda memesan: Nasi Ikan Goreng" 
menuInvalid: .asciiz "Masukkan Anda tidak valid\n\n" # Keluaran input tidak valid

.text 
.globl main
main:
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu # register a0 = print isi menu
    syscall # execute
    
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
    
    j main # saat masih masuk ke line ini berarti program tidak valid sehingga di loop ke main lagi
    
get1:
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu1 # register a0 = print isi menu1
    syscall # execute
    j exit # jump to exit
    
get2:
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu2 # register a0 = print isi menu2
    syscall # execute
    j exit # jump to exit
    
get3:
    li $v0, 4 # syscall 4 = print string in register a0
    la $a0, menu3 # register a0 = print isi menu3
    syscall # execute
    j exit # jump to exit
    
exit:
    li $v0, 10 # syscall 10 = exit program
    syscall # execute
# Nama  : Eugenius Mario Situmorang
# NPM   : 2106750484
# Kelas : POK - B
# Lab   : 4
.data
masukan: .asciiz  "\n\nMasukkan data (1-127 Character): " # Meminta input string
newLine: .asciiz "\n" # Ganti baris string
format: .asciiz "           "

.text 
main:
    # Mengambil input dari pengguna
    la $a0, masukan # Load masukan
    li $v0, 4 # Print string
    syscall # Execute

    # Mengambil input dari user untuk addressing
    la $a0,format  # Load address theString ke a0
    li $a1,128 # Load sizeOfInput+1 (127+1) ke a1
    li $v0,8 # Membaca string
    syscall # Execute

    # Mengeset nilai total dari character masukan
    li $s7,127     

    # Jump sesuai perintah
    jal uppercase  
    jal sort
    jal print
    j exit

# Mengolah data dari inputan user menggunakan ascii
uppercase:

    la $s0, format    # Load base addres ke $t0
    add $t6,$zero,$zero  # Set index ($t6)

    lupper:
        beq $t6,$s7,done # Cek val jika benar kembali ke ra

	# Mengambil isi array
        add $s2,$s0,$t6 
        lb  $t1,0($s2)

        # Jika char menggunakan lowercase
        sgt  $t2,$t1,96
        slti $t3,$t1,123
        and $t3,$t2,$t3
        # Jika tidak maka jangan store
        beq $t3,$zero,isUpper
        addi $t1,$t1,-32
        sb   $t1, 0($s2)

        isUpper:
        # Tambahkan counter dan loop kembali
        addi $t6,$t6,1
        j lupper

# Bubble sort dengan nilai ascii 
sort:   
    # Inisiasi counter
    add $t0,$zero,$zero 

    # Loop bagian luar
    loop:
        # Jika val sesuai maka sudahi
        beq $t0,$s7,done

        #  loop ( 10 - i - 1 ) 
        sub $t7,$s7,$t0
        addi $t7,$t7,-1

       	# Inisiasi counter dalam
        add $t1,$zero,$zero

        # Loop bagian dalam
        jLoop:
            # Ketika val sesuai maka continue
            beq $t1,$t7,continue

            #  Load Array[i] and Array[i+1]
            add $t6,$s0,$t1
            lb  $s1,0($t6)
            lb  $s2,1($t6)

            # Jika ascii array saat ini lebih besar dari ascii 
            # array selanjutnya maka swap
            sgt $t2, $s1,$s2
            # Jika tidak ya tidak usah
            beq $t2, $zero, good
            sb  $s2,0($t6)
            sb  $s1,1($t6)

            good:
            # Count dan loop kembali
            addi $t1,$t1,1
            j jLoop

        continue:
        # Count dan loop kembali
        addi $t0,$t0,1
        j loop

# Mencetak apapun yang ada di dalam array
print:

    # Print baris baru
    la $a0,newLine
    li $v0,4
    syscall 

    # Inisiasi counter 
    add $t6,$zero,$zero # Set index $t6

    lprint:
        # Cek val jika sesuai maka sudahi
        beq $t6,$s7,done  

        #  Load Array[i] ke t1 dan cetak
        add $t1,$s0,$t6 
        lb $a0, 0($t1) # Load argument
        li $v0, 11 # Load opcode
        syscall # Execute
        
        # Count dan loop kembali
        addi $t6,$t6,1  
        j lprint

# Label selesai dan keluar dari program
done:
    jr $ra
    
exit:
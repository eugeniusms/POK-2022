; Nama  : Eugenius Mario Situmorang
; NPM   : 2106750484
; Kelas : POK-B

; Memasukkan definisi dari tipe-tipe prosesor yang digunakan
.include "m8515def.inc"
; Mendeskripsikan nama dari register r2
.def hasil = r2

; Label main merupakan block program utama yang dijalankan
main:
    ; Load immediate HIGH(2*SOMETHING) ke ZH
    ldi ZH, HIGH(2*SOMETHING)
    ; Load immediate LOW(2*SOMETHING) ke ZL
    ldi ZL, LOW(2*SOMETHING)

; Label loop 
loop:
    ; Load memori program
    lpm
    ; Melakukan test nol atau minus pada r0
    tst r0
    ; Saat sama dengan satu maka jalankan block program dalam label stop 
    breq stop
    ; Melakukan penyalinan register r0 ke r16
    mov r16, r0

; Label funct1
funct1:
    ; Melakukan perbandingan antara isi dari r16 dengan angka 7
    cpi r16, 7
    ; Saat memiliki hubungan "Less Than" maka jalankan block program dalam label funct2
    brlt funct2
    ; Melakukan pengurangan isi r16 dengan angka 7
    subi r16, 7
    ; Melakukan relative jump ke funct1 baik dalam posisi manapun
    rjmp funct1

; Label funct2
funct2:
    ; Melakukan penambahan isi register r1 dengan isi register r16
    add r1, r16
    ; Melakukan penambahan immediate 1 ke word Zl
    adiw Zl, 1
    ; Melakukan relative jump ke loop baik dalam posisi manapun
    rjmp loop

; Label stop
stop:
    ; Melakukan penyalinan register R1 ke dalam hasil
    mov hasil, R1

; Label forever
forever:
    ; Eternal loop
    rjmp forever

; Mendefinisikan nilai-nilai yang disimpan pada memori program
SOMETHING:
; .DB : Define Constant Byte
.db 1, 3, 6, 9
.db 0, 0
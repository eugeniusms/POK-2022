; Nama  : Eugenius Mario Situmorang
; NPM   : 2106750484
; Kelas : POK-B

; Memasukkan definisi dari tipe-tipe prosesor yang digunakan
.include "m8515def.inc"
; Mendeskripsikan nama dari register r1, hasil akan disimpan dalam r1
.def hasil = r1

; Label main merupakan block program utama yang dijalankan
main:
    ; Inisialisasi Z pointer
    ; Load immediate HIGH(2*SOMETHING) ke ZH
    ldi ZH, HIGH(2*SOMETHING)
    ; Load immediate LOW(2*SOMETHING) ke ZL
    ldi ZL, LOW(2*SOMETHING)

    ; Load memori program
    ; load lower byte ke dalam r1
    lpm r1, Z+ 
    ; load upper byte ke dalma r2
    lpm r2, Z

    ; Menggunakan pendekatan while-loop tanpa rekursif maka 
    ; pencarian GCD dapat dilakukan sebagai berikut
    
    ; Melakukan pembandingan r1 dan r2
    cp r1, r2
    ; Ketika r1 tidak sama dengan r2 maka program akan menjalankan block while
    brne while
    ; Saat sama dengan maka langsung jalankan block program dalam label stop 
    breq stop

; Label while
while:
    ; Melakukan pembandingan r1 dan r2
    cp r1, r2
    ; Saat r1 == r2 maka stop program
    breq stop
    ; Saat r1 < r2 maka r2 -= r1
    brlt r2kurangr1
    ; Saat r1 > r2 maka r1 -= r2
    rjmp r1kurangr2 

; Label r1kurangr2
r1kurangr2:
    ; Melakukan pengurangan r1 = r1 - r2
    sub r1, r2
    ; Melakukan relative jump menuju while
    rjmp while

; Label r2kurangr1
r2kurangr1:
    ; Melakukan pengurangan r2 = r2 - r1
    sub r2, r1
    ; Melakukan relative jump menuju while
    rjmp while

; Label stop
stop:
    ; Melakukan penyalinan register R1 ke dalam hasil
    mov hasil, r1
    ; Baik r1 maupun r2 sama isinya sehingga hasil dapat dilihat
    ; baik pada r1 maupun r2

; Label forever
forever:
    ; Eternal loop
    rjmp forever

; Mendefinisikan nilai-nilai yang disimpan pada memori program
SOMETHING:
; .DB : Define Constant Byte
.db 8, 6
.db 0, 0
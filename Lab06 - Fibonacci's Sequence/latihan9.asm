.cseg
    rjmp main

month:
    .dw 4

main:
    ; Instruksi main
    ldi r28, low(RAMEND)
    ldi r29, high(RAMEND)
    out SPH, r29 ; Inisialisasi stack pointer
    out SPL, r28 ; SRAM Address tinggi

    ldi r30, low(month << 1) ; Z point ke month
    ldi r31, high(month << 1)
    lpm r24, Z+ ; Parameter 4 ditaruh di r25:r24
    lpm r25, Z
    rcall fib ; Call fib(4) 
    
    ; Tidak ada return

loopforever:
    ; Relative jump ke loopforever
    rjmp loopforever 

fib:
    ; Memulai label untuk fibonacci
    push r16 ; Push R16
    push r17 ; Menyimpan R16 dan R17 ke stack
    push r28 ; Menyimpan Y ke stack
    push r29
    in r28, SPL
    in r29, SPH
    sbiw r29:r28, 2 ; Y point ke bawah

    out SPH, r29 ; Memperbarui SP 
    out SPL, r28 ; Atas stack yang baru
    std Y+1, r24 ; Pass parameternya
    std Y+2, r25 ; Ke formal parameter
    cpi r24, 0 ; Bandingkan n dengan 0
    clr r0
    cpc r25, r0
    brne L3 ; Saat n != 0, maka menuju ke L3
    ldi r24, 1 ; n == 0
    ldi r25, 0 ; Return 1

    rjmp L2 ; Jump ke L2 

L3: 
    cpi r24, 1 ; Bandingkan n with 1
    clr r0
    cpc r25, r0
    brne L4 ; Jika n != 1 maka ke L4
    ldi r24, 1 ; n == 1
    ldi r25, 0 ; Return 1

    rjmp L2 ; Jump ke L2

L4: 
    ldd r24, Y+1 ; n >= 2
    ldd r25, Y+2 ; Unduh parameter n
    sbiw r25:r24, 1 ; Pass n - 1 ke callee
    rcall fib ; call fib(n - 1)
    movw r16, r24 ; Meletakkan nilai ke r17:r16
    ldd r24, Y+1 ; Unduh parameter n
    ldd r25, Y+2
    sbiw r25:r24, 2 ; Pass n - 2 ke callee
    rcall fib ; call fib(n-2)
    add r24, r16 ; r25:r25 = fib(n - 1) + fib(n - 2)
    adc r25, r17

L2:
    adiw r29:r28, 2 ; Melemparkan lokasi stack frame untuk fib()
    out SPH, r29 ; Kembalikan SP
    out SPL, r28
    pop r29 ; Kembalikan Y
    pop r28
    pop r17 ; Kembalikan r17 and r16
    pop r16
    ret
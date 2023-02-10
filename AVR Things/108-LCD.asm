;**** A P P L I C A T I O N   N O T E   A V R 1 0 8 ************************ 
;* VERSI INI sudah bersih---------------------------????????
;* Title:		Load Program Memory 
;* Version:		1.0 
;* Last updated:	98.02.27 
;* Target:		AT90Sxx1x and higher (Devices with SRAM) 
;* 
;* Support E-mail:	avr@atmel.com 
;* 
;* DESCRIPTION 
;* This Application note shows how to use the Load Program Memory (LPM) 
;* instruction. The App. note loads the string "Hello World" from  
;* program memory byte by byte, and puts it onto port B. 
;* 
;*************************************************************************** 
 
 
.include "8515def.inc" 
 
.device AT90S8515			; Specify device 
 
.def	BILANGAN = r15   ; UNTUK MELETAKKAN BILANGAN
.def	temp	=r16
.def    INDA = r18	; values sent to PORTC
.def	A  = r19   ; value to be printed


; Define temporary variable 
; PORTA.0 as EN of LCD
; PORTA.1 as RS of LCD
; PORTA.2 as RW of LCD
; PORTB used by Keypad
; PORTC as INSTRUCTION OR DATA to LCD
; PORTD for LED
 
start:	
	ldi	temp,low(RAMEND) 
	out	SPL,temp		; Set stack pointer to last internal RAM location 
	ldi	temp,high(RAMEND) 
	out	SPH,temp 
 
	rcall 	INIT
	rcall 	CLEAR_LCD


 
	; Load the address of 'message' into the Z register. Multiplies 
	; word address with 2 to achieve the byte address, and uses the 
	; functions high() and low() to calculate high and low address byte. 
 
	ldi	ZH,high(2*message)	; Load high part of byte address into ZH 
	ldi	ZL,low(2*message)	; Load low part of byte address into ZL 
 
loadbyte: 
	lpm				; Load byte from program memory into r0 
 
	tst	r0			; Check if we've reached the end of the message 
	breq	quit			; If so, quit 
 
	mov 	A, r0		; Put the character onto Register  r19 (reg A)
	rcall 	WRITE_TEXT

	rcall	one_sec_delay		; A short delay 
 
	adiw	ZL,1			; Increase Z registers 
	rjmp	loadbyte 
 
 
quit:	rjmp quit 
 
INIT:
; INIT PORT A & C
	ldi	temp,$ff 
	out	DDRA,temp		; Set port A as output 
 	out	DDRC,temp		; Set port C as output 
 
; INIT_LCD: 
	cbi 	PORTA,1	; CLR RS
	ldi 	INDA,0x38	; MOV DATA,0x38 --> 8bit, 2line, 5x7
	out 	PORTC,INDA
	sbi 	PORTA,0	; SETB EN
	cbi 	PORTA,0	; CLR EN
	rcall 	WAIT_LCD
	cbi 	PORTA,1	; CLR RS
	ldi 	INDA,$0C	; MOV DATA,0x0E --> disp ON, cursor ON, blink OFF
	out 	PORTC,INDA
	sbi 	PORTA,0	; SETB EN
	cbi 	PORTA,0	; CLR EN
	rcall 	WAIT_LCD
	cbi 	PORTA,1	; CLR RS
	ldi 	INDA,$06	; MOV DATA,0x06 --> increase cursor, display sroll OFF
	out 	PORTC,INDA
	sbi 	PORTA,0	; SETB EN
	cbi 	PORTA,0	; CLR EN
	rcall 	WAIT_LCD
	ret


 CLEAR_LCD:
	cbi 	PORTA,1	; CLR RS
	ldi 	INDA,$01	; MOV DATA,0x01
	out 	PORTC,INDA
	sbi 	PORTA,0	; SETB EN
	cbi 	PORTA,0	; CLR EN

; BLINK-BLINK	
	cbi 	PORTA,1	; CLR RS
	ldi 	INDA,$0F	; MOV DATA,0x0F
	out 	PORTC,INDA
	sbi 	PORTA,0	; SETB EN
	cbi 	PORTA,0	; CLR EN
	rcall 	WAIT_LCD
	ret


WRITE_TEXT: ; A stores ASCII to be printed on LCD
	sbi 	PORTA,1	; SETB RS
	out 	PORTC, A
	sbi 	PORTA,0	; SETB EN
	cbi 	PORTA,0	; CLR EN
	rcall 	WAIT_LCD
	ret



;************** LCD DRIVER STARTS HERE *******************
WAIT_LCD:
	nop
	nop
	nop
	nop
	nop
	ret

one_sec_delay: 
	ldi	r20, 255
	ldi	r21, 200
	ldi	r22, 160

delay:	
	dec	r21 
	brne	delay 
	dec	r22 
	brne	delay 
	nop
	ret 
 
 
message: 
.db	"Hello World" 
.db	0 
 
 

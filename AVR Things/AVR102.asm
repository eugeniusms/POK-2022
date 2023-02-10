;**** A P P L I C A T I O N   N O T E   A V R 1 0 2 ************************
;*
;* Title:		Block Copy Routines
;* Version:		1.1
;* Last updated:	97.07.04
;* Target:		AT90Sxx1x (Devices with SRAM)
;*
;* Support E-mail:	avr@atmel.com
;* 
;* DESCRIPTION
;* This Application Note shows how to copy a block of data from Program
;* memory to SRAM and from one SRAM area to another
;*
;***************************************************************************

.include "8515def.inc"

	rjmp	RESET	;reset handle

;***************************************************************************
;*
;* "flash2ram"
;*
;* This subroutine copies a block of data from the Program memory (Flash) 
;* to the internal SRAM. The following parameters must be set up prior to 
;* calling the subroutine:
;* Z-pointer: 	Flash block start address x 2 (WORD oriented code segment)
;* Y-pointer:	ram block start address
;* romsize:	block size
;*
;* Number of words	:5 + return
;* Number of cycles	:10 x block size + return
;* Low Registers used	:1 (r0)
;* High Registers used	:1 (flashsize)
;* Pointers used	:Y, Z
;*
;***************************************************************************

;***** Subroutine Register variables

.def	flashsize=r16		;size of block to be copied

;***** Code				

flash2ram:
	lpm			;get constant
	st	Y+,r0		;store in SRAM and increment Y-pointer
	adiw	ZL,1		;increment Z-pointer
	dec	flashsize
	brne	flash2ram	;if not end of table, loop more
	ret


;***************************************************************************
;*
;* "ram2ram"
;*
;* This subroutine copies one block of data from one SRAM area to another.
;* The following parameters must be set up prior to calling the subroutine:
;*
;* Z-pointer: 	start of RAM area to copy from
;* Y-pointer:	start of RAM area to copy to
;* ramsize  :   size of block to copy
;*
;* Number of words	:4 + return
;* Number of cycles	:6 x block size + return
;* Low Registers used	:1 (ramtemp)
;* High Registers used	:1 (ramsize)
;* Pointers used	:Y, Z	
;*
;***************************************************************************

;***** Subroutine Register variables

.def	ramtemp	=r1		;temporary storage register
.def	ramsize	=r16		;size of block to be copied

;***** Code				

ram2ram:
	ld	ramtemp,Z+	;get data from BLOCK1
	st	Y+,ramtemp	;store data to BLOCK2
	dec	ramsize		;
	brne	ram2ram		;if not done, loop more
	ret

;****************************************************************************
;*
;* Test Program
;*
;* This program copies 20 bytes of data from the Program memory to the SRAM
;* area beginning at location BLOCK1. It then makes a second copy to the
;* area beginning at location BLOCK2.
;*
;****************************************************************************

.equ	BLOCK1	=$60		;start address of SRAM array #1
.equ	BLOCK2	=$80		;start address of SRAM array #2

;***** Main Program Register variables

.def	temp	=r16		;temporary storage variable

;***** Code

RESET:
	ldi	temp,low(RAMEND)
	out	SPL,temp	;init Stack Pointer		
	ldi	temp,high(RAMEND)
	out	SPH,temp

;***** Copy 20 bytes ROM -> RAM

	ldi	ZH,high(F_TABLE*2)
	ldi	ZL,low(F_TABLE*2);init Z-pointer
	ldi	YH,high(BLOCK1)
	ldi	YL,low(BLOCK1)	;init Y-pointer
	ldi	flashsize,20
	rcall	flash2ram	;copy 20 bytes

;***** Copy 20 bytes RAM -> RAM

	ldi	ZH,high(BLOCK1)
	ldi	ZL,low(BLOCK1)	;init Z-pointer
	ldi	YH,high(BLOCK2) ;(not necessary in this specific case)
	ldi	YL,low(BLOCK2)	;init Y-pointer
	ldi	ramsize,20	
	rcall	ram2ram		;copy 20 bytes
			
forever:rjmp	forever		;eternal loop	

F_TABLE:
	.db	0,1		;start of table (20 bytes)
	.db	2,3
	.db	4,5
	.db	6,7
	.db	8,9
	.db	10,11
	.db	12,13
	.db	14,15
	.db	16,17
	.db	18,19

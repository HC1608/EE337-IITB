; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable
	
org 0H
ljmp main

org 0BH									;interrupt vector for timer0
ljmp timer_jump							;jump to interrupt service routine for timer0

org 30H
main:
	mov TMOD, #01H						;set timer0 in mode 1
	mov P1, #0FH						;configure switches as input
	forever:
		call delay						;initial delay for lcd power up
		call delay
		call lcd_init 					;initialise LCD
		call delay
		call delay
		mov r0, #0H 					;to hold the number of times timer overflows
		mov TMOD, #01H					;set timer0 in mode 1
		mov a,#83H		 				;put cursor on first row, third column
		call lcd_command	 			;send command to LCD
		call delay
		mov dptr,#my_string1      	
		call lcd_sendstring	    		;call text strings sending routine
		call delay
		mov a,#0C3H	  					;Put cursor on second row,third column
		call lcd_command
		call delay
		mov dptr,#my_string2
		call lcd_sendstring	    		;call text strings sending routine
		call delay_1s
		call delay_1s					;wait 2s
		setb P1.4						;turnon LED
										;setup timer0 in interrupt mode
		setb EA
		setb ET0
		mov TH0, #0H
		mov TL0, #0H
		setb TR0						;start counting
		waitup:
			jnb P1.0, waitup			;wait until the switch is pressed
		waspressed:
			clr TR0
			clr P1.4					;turnoff LED
			mov r1, TH0
			mov r2, TL0
			call convert_to_ms
			mov a,#82H		 			;put cursor on first row, fifth column
			call lcd_command	 		;send command to LCD
			call delay
			mov dptr,#my_string3      	
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,#0C0H		  			;Put cursor on second row,third column
			call lcd_command
			call delay
			mov 31H, 60H
			call ascii_finder
			mov a,64H
			acall lcd_senddata
			mov 31H, 61H
			call ascii_finder
			mov a,64H
			acall lcd_senddata
			mov 31H, 62H
			call ascii_finder
			mov a,64H
			acall lcd_senddata
			mov 31H, 63H
			call ascii_finder
			mov a,64H
			acall lcd_senddata
			mov dptr,#my_string4
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			clr EA						;remove interrupt mode from timer0
			clr ET0
			call delay_1s
			call delay_1s
			call delay_1s
			call delay_1s
			call delay_1s
			jmp forever

ascii_finder:
	push 1
	mov r1, 31H
	mov a, r1
	call check_the_val
	mov 64H, a; move the accumulator to 61H
	pop 1
	ret

check_the_val:
		add a,#30H
		ret

timer_jump:
	inc R0				;the timer has overflown so increment R0
	mov TH0,#0H
	mov TL0,#0H
	setb TR0
	setb ET0
	reti
	
delay_1s:				;timer will take 40*25ms = 1s
	mov r2, #40
	repeat:
		call delay_25ms
		djnz r2, repeat
		ret

delay_25ms:				;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH0, #3CH		;move the values to TH, TL register 
	mov TL0, #0B0H		;to set TH,TL = -C350 (hex) - 50000 states
	setb TR0			;setup timer
	loopsie: 				;polling
		jb TF0, myexit	;exit if flag bit is 1
		jmp loopsie
	myexit:
		clr TF0			;clear flag bit
		ret

convert_to_ms:	
	mov a, r0
	mov b, #21H			;for overflows, timer will take 65,535/2MHz = 32767us ~ 33ms = 22H
	mul ab
	mov 51H, a
	mov 50H, b
	mov r1, 50H
	mov r0, 51H
	mov r3,#00H
	mov r4,#0AH
	call UDIV16
	mov 63H,r2
	mov r3,#00H
	mov r4,#0AH
	call UDIV16
	mov 62H,r2
	mov r3,#00H
	mov r4,#0AH
	call UDIV16
	mov 61H,r2
	mov r3,#00H
	mov r4,#0AH
	call UDIV16
	mov 60H,r2
	ret
	
;====================================================================
; subroutine UDIV16
; 16-Bit / 16-Bit to 16-Bit Quotient & Remainder Unsigned Divide
;
; input:    r1, r0 = Dividend X
;           r3, r2 = Divisor Y
;
; output:   r1, r0 = quotient Q of division Q = X / Y
;           r3, r2 = remainder 
;
; alters:   acc, B, dpl, dph, r4, r5, r6, r7, flags
;====================================================================

UDIV16:        mov     r7, #0          ; clear partial remainder
               mov     r6, #0
               mov     B, #16          ; set loop count

div_loop:      clr     C               ; clear carry flag
               mov     a, r0           ; shift the highest bit of
               rlc     a               ; the dividend into...
               mov     r0, a
               mov     a, r1
               rlc     a
               mov     r1, a
               mov     a, r6           ; ... the lowest bit of the
               rlc     a               ; partial remainder
               mov     r6, a
               mov     a, r7
               rlc     a
               mov     r7, a
               mov     a, r6           ; trial subtract divisor
               clr     C               ; from partial remainder
               subb    a, r2
               mov     dpl, a
               mov     a, r7
               subb    a, r3
               mov     dph, a
               cpl     C               ; complement external borrow
               jnc     div_1           ; update partial remainder if
                                       ; borrow
               mov     r7, dph         ; update partial remainder
               mov     r6, dpl
div_1:         mov     a, r4           ; shift result bit into partial
               rlc     a               ; quotient
               mov     r4, a
               mov     a, r5
               rlc     a
               mov     r5, a
               djnz    B, div_loop
               mov     a, r5           ; put quotient in r0, and r1
               mov     r1, a
               mov     a, r4
               mov     r0, a
               mov     a, r7           ; get remainder, saved before the
               mov     r3, a           ; last subtraction
               mov     a, r6
               mov     r2, a
               ret

subtract:				;subroutine to perform subtraction of a 16 bit number from FFFFH 
	push 0
	push 1
	mov r0, 40H
	mov r1, 41H
	mov a, #0FFH
	subb a, r0
	mov 42H, a
	mov a, #00H
	subb a, r1
	mov 43H, a
	pop 1
	pop 0
	ret
		
org 200H
;------------------------LCD Initialisation routine----------------------------------------------------
lcd_init:
         mov   LCD_data,#38H  ;Function set: 2 Line, 8-bit, 5x7 dots
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
	     acall delay

         mov   LCD_data,#0CH  ;Display on, Curson off
         clr   LCD_rs         ;Selected instruction register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay
         mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay

         mov   LCD_data,#06H  ;Entry mode, auto increment with no shift
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en

		 acall delay
         
         ret                  ;Return from routine
;-----------------------command sending routine-------------------------------------
 lcd_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
;-----------------------data sending routine-------------------------------------		     
 lcd_senddata:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret                  ;Return from busy routine

;-----------------------text strings sending routine-------------------------------------
lcd_sendstring:
	push 0e0h
	lcd_sendstring_loop:
	 	 clr   a                 			;clear Accumulator for any previous data
	         movc  a,@a+dptr        	 	;load the first character in accumulator
	         jz    exit              		;go to exit if zero
	         acall lcd_senddata      		;send first char
	         inc   dptr              		;increment data pointer
	         sjmp  LCD_sendstring_loop      ;jump back to send the next character
exit:    pop 0e0h
         ret                     			;End of routine

;----------------------delay routine-----------------------------------------------------
delay:	 push 0
	 push 1
         mov r0,#1
loop2:	 mov r1,#255
	 loop1:	 djnz r1, loop1
	 djnz r0, loop2
	 pop 1
	 pop 0 
	 ret
;--------------------------------------------------------
org 300H
my_string1:
DB   "Toggle SW1", 00H
	
my_string2:
DB   "if LED glows", 00H
	
my_string3:
DB   "Reaction Time", 00H	

my_string4:
DB	" milliseconds", 00H	
	
end	

	
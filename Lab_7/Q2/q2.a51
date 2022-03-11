; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable
	
org 0H
jmp main

org 30H
main:
	mov TMOD,#11H 					;set the timers 0 and 1 in mode 1
	mov P1,#0H						
	call delay						;initial delay for lcd power up
	call delay
	call lcd_init 					;initialise LCD
	call delay
	call delay
	mov a,#82H		 				;put cursor on first row, third column
	call lcd_command	 			;send command to LCD
	call delay
	mov dptr,#my_string1      	
	call lcd_sendstring	    		;call text strings sending routine
	forever:
		mov r2, #30					;for 750ms
		repeat_1:
			call n1_delay_25ms
			djnz r2, repeat_1
		mov r2, #30					;for 750ms
		repeat_2:
			call n2_delay_25ms		
			djnz r2, repeat_2
		mov r2, #30					;for 750ms
		repeat_3:
			call n3_delay_25ms
			djnz r2, repeat_3
		mov r2, #30					;for 750ms
		repeat_4:
			call n2_delay_25ms
			djnz r2, repeat_4
		mov r2, #40					;for 1s
		repeat_5:
			call n4_delay_25ms
			djnz r2, repeat_5
		mov r2, #20					;for 500ms
		clr P0.7
		repeat_6:
			call delay_25ms
			djnz r2, repeat_6
		mov r2, #40					;for 1s
		repeat_7:
			call n4_delay_25ms
			djnz r2, repeat_7
		mov r2, #40
		repeat_8:
			call n5_delay_25ms		;for 1s
			djnz r2, repeat_8
		jmp forever


delay_25ms:				;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH1, #3CH		;move the values to TH, TL register 
	mov TL1, #0B0H		;to set TH,TL = -C350 (hex) - 50000 states
	setb TR1			;setup timer
	loopsie: 			;polling
		jb TF1, myexit	;exit if flag bit is 1
		jmp loopsie
	myexit:
		clr TF1			;clear flag bit
		ret

n1_delay_25ms:			;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH1, #3CH		;move the values to TH, TL register 
	mov TL1, #0B0H		;to set TH,TL = -C350 (hex) - 50000 states
	setb TR1			;setup timer
	loopsie_1: 			;polling
		jb TF1, myexit_1;exit if flag bit is 1
		cpl P0.7		;complement the bit
		call n1_delay	;wait for T/2
		jmp loopsie_1
	myexit_1:
		clr TF1			;clear flag bit
		ret

n2_delay_25ms:			;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH1, #3CH		;move the values to TH, TL register 
	mov TL1, #0B0H		;to set TH,TL = -C350 (hex) - 50000 states
	setb TR1			;setup timer
	loopsie_2: 			;polling
		jb TF1, myexit_2;exit if flag bit is 1
		cpl P0.7		;complement the bit
		call n2_delay	;wait for T/2
		jmp loopsie_2
	myexit_2:
		clr TF1			;clear flag bit
		ret

n3_delay_25ms:			;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH1, #3CH		;move the values to TH, TL register 
	mov TL1, #0B0H		;to set TH,TL = -C350 (hex) - 50000 states
	setb TR1			;setup timer
	loopsie_3: 			;polling
		jb TF1, myexit_3;exit if flag bit is 1
		cpl P0.7		;complement the bit
		call n3_delay	;wait for T/2
		jmp loopsie_3
	myexit_3:
		clr TF1			;clear flag bit
		ret

n4_delay_25ms:			;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH1, #3CH		;move the values to TH, TL register 
	mov TL1, #0B0H		;to set TH,TL = -C350 (hex) - 50000 states
	setb TR1			;setup timer
	loopsie_4: 			;polling
		jb TF1, myexit_4;exit if flag bit is 1
		cpl P0.7		;complement the bit
		call n4_delay	;wait for T/2
		jmp loopsie_4
	myexit_4:
		clr TF1			;clear flag bit
		ret

n5_delay_25ms:			;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH1, #3CH		;move the values to TH, TL register 
	mov TL1, #0B0H		;to set TH,TL = -C350 (hex) - 50000 states
	setb TR1			;setup timer
	loopsie_5: 			;polling
		jb TF1, myexit_5;exit if flag bit is 1
		cpl P0.7		;complement the bit
		call n5_delay	;wait for T/2
		jmp loopsie_5
	myexit_5:
		clr TF1			;clear flag bit
		ret

n1_delay:				;for note 1, 1/(440Hz)
						;timer will take 4544/2MHz = 2272us
	mov TH0, #0EEH		;move the values to TH, TL register 
	mov TL0, #40H		;to set TH,TL = -11C0 (hex) - 4544 states
	setb TR0			;setup timer
	loopsie_n1: 		;polling
		jb TF0, myexit_n1	;exit if flag bit is 1
		jmp loopsie_n1
	myexit_n1:
		clr TF0			;clear flag bit
		ret

n2_delay:				;for note 2, 1/(247*2Hz)
						;timer will take 4048/2MHz = 2024us
	mov TH0, #0F0H		;move the values to TH, TL register 
	mov TL0, #30H		;to set TH,TL = -FD0 (hex)
	setb TR0			;setup timer
	loopsie_n2: 		;polling
		jb TF0, myexit_n2	;exit if flag bit is 1
		jmp loopsie_n2
	myexit_n2:
		clr TF0			;clear flag bit
		ret

n3_delay:				;for note 2, 1/(294*2Hz)
						;timer will take 3400/2MHz = 1700us
	mov TH0, #0F2H		;move the values to TH, TL register 
	mov TL0, #0B8H		;to set TH,TL = -D48 (hex)
	setb TR0			;setup timer
	loopsie_n3: 		;polling
		jb TF0, myexit_n3	;exit if flag bit is 1
		jmp loopsie_n3
	myexit_n3:
		clr TF0			;clear flag bit
		ret

n4_delay:				;for note 2, 1/(370*2Hz)
						;timer will take 2702/2MHz = 1351us
	mov TH0, #0F5H		;move the values to TH, TL register 
	mov TL0, #72H		;to set TH,TL = -A8E (hex)
	setb TR0			;setup timer
	loopsie_n4: 		;polling
		jb TF0, myexit_n4	;exit if flag bit is 1
		jmp loopsie_n4
	myexit_n4:
		clr TF0			;clear flag bit
		ret

n5_delay:				;for note 2, 1/(370*2Hz)
						;timer will take 3030/2MHz = 1515us
	mov TH0, #0F4H		;move the values to TH, TL register 
	mov TL0, #2AH		;to set TH,TL = -BD6(hex)
	setb TR0			;setup timer
	loopsie_n5: 		;polling
		jb TF0, myexit_n5	;exit if flag bit is 1
		jmp loopsie_n5
	myexit_n5:
		clr TF0			;clear flag bit
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
DB   "ROLLING TIME", 00H
end	
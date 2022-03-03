; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

org 0H
jmp main
org 30H
	
main:
	mov TMOD, #01H		;set timer0 in mode 1
	mov P1, #00H		;configure as output
	mov 40H, #0C3H		;to set TH,TL = C350 (hex) = 50000 (dec)
	mov 41H, #50H		
	mov 70H, #23H		;set the default values given in the table in handout
	mov 71H, #45H
	call subtract		;load 2s complement into 42H and 43H
						;initial delay for lcd power up
	call delay
	call delay
	call lcd_init 		;initialise LCD
	call delay
	call delay
	call delay
	
	forever:							;primary subroutine for q2
		level1:
			mov a,70H	
			anl a, #0FH					;take first digit
			mov r7, a
			swap a
			mov P1, a					;show on the LEDs
			swap a
			call bin_converter			;convert digit to hex coded binary
			call ascii_finder			;get the ASCII representation in 60H,61H,62H,64H memory locations
			mov a,#85h		 			;put cursor on first row, fifth column
			call lcd_command	 		;send command to LCD
			call delay
			mov dptr,#my_string1      	
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,#0C3h		  			;Put cursor on second row,third column
			call lcd_command
			call delay
			mov dptr,#my_string5
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,60H
			acall lcd_senddata
			mov a,61H
			acall lcd_senddata
			mov a,62H
			acall lcd_senddata
			mov a,63H
			acall lcd_senddata
			call delay_1s
		level2:
			mov a,70H
			anl a, #0F0H				;take second digit
			swap a
			mov r7, a
			swap a
			mov P1, a
			swap a
			call bin_converter
			call ascii_finder
			mov a,#85h		 			
			call lcd_command	 		;send command to LCD
			call delay
			mov dptr,#my_string2      	
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,#0C3h		  
			call lcd_command
			call delay
			mov dptr,#my_string5
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,60H
			acall lcd_senddata
			mov a,61H
			acall lcd_senddata
			mov a,62H
			acall lcd_senddata
			mov a,63H
			acall lcd_senddata
			call delay_1s
		level3:
			mov a,71H					
			anl a, #0FH					;take third digit
			mov r7, a
			swap a
			mov P1, a
			swap a
			call bin_converter
			call ascii_finder
			mov a,#85h		 			
			call lcd_command	 		;send command to LCD
			call delay
			mov dptr,#my_string3      	
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,#0C3h		  
			call lcd_command
			call delay
			mov dptr,#my_string5
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,60H
			acall lcd_senddata
			mov a,61H
			acall lcd_senddata
			mov a,62H
			acall lcd_senddata
			mov a,63H
			acall lcd_senddata
			call delay_1s
		level4:
			mov a,71H				
			anl a, #0F0H				;take fourth digit
			swap a
			mov r7, a
			swap a
			mov P1, a
			swap a
			call bin_converter
			call ascii_finder
			mov a,#85h		 			
			call lcd_command	 		;send command to LCD
			call delay
			mov dptr,#my_string4      	
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,#0C3h		  
			call lcd_command
			call delay
			mov dptr,#my_string5
			call lcd_sendstring	    	;call text strings sending routine
			call delay
			mov a,60H
			acall lcd_senddata
			mov a,61H
			acall lcd_senddata
			mov a,62H
			acall lcd_senddata
			mov a,63H
			acall lcd_senddata
			call delay_1s
		jmp forever

bin_converter:
	mov a, r7				 ;first bit
	anl a, #08H
	cjne a, #08H, skip_1	 ;check if the first bit is 1
		mov r6,#10H
		jmp post_skip_1
	skip_1:
		mov r6,#00H
	post_skip_1:
	mov a, r7				 ;second bit
	anl a, #04H
	cjne a, #04H, skip_2	;check if the second bit is 1
		mov a,r6
		add a,#01H
		jmp post_skip_2
	skip_2:
		mov a,r6
	post_skip_2:
	mov 31H, a
	mov a, r7 				 ;third bit
	anl a, #02H
	cjne a, #02H, skip_3	;check if the third bit is 1
		mov r6,#10H
		jmp post_skip_3
	skip_3:
		mov r6,#00H
	post_skip_3:
	mov a, r7				 ;fourth bit
	anl a, #01H
	cjne a, #01H, skip_4	;check if the fourth bit is 1
		mov a,r6
		add a,#01H
		jmp post_skip_4
	skip_4:
		mov a,r6
	post_skip_4:
	mov 32H, a
	ret

ascii_finder:
	mov r1, 31H; the first two bits
	mov a, r1
	mov b, #10H
	div ab; divide by 10H to get both digits 
	mov r2, a; the first digit
	mov r3, b; the second digit
	mov a, r2
	call check_the_val
	mov 60H, a; move the accumulator to 60H
	mov a, r3
	call check_the_val
	mov 61H, a; move the accumulator to 61H
	mov r1, 32H; the last two bits
	mov a, r1
	mov b, #10H
	div ab; divide by 10H to get both digits 
	mov r2, a; the first digit
	mov r3, b; the second digit
	mov a, r2
	call check_the_val
	mov 62H, a; move the accumulator to 60H
	mov a, r3
	call check_the_val
	mov 63H, a; move the accumulator to 61H
	ret

check_the_val:
		cjne a,#9H,unequal; check if equal to 9
		add a,#30H
		ret
		unequal:
			jc smaller; check if smaller than 9
			;greater than 9 case
			;add 37H to get ASCII for A-F
			add a, #37H
			ret
			smaller:
				;add 30H to get ASCII for 0-9
				add a, #30H
				ret

delay_1s:				;timer will take 40*25ms = 1s
	mov r2, #40
	repeat:
		call delay_25ms
		djnz r2, repeat
		ret

delay_25ms:				;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH0, 42H		;move the values to TH, TL register 
	mov TL0, 43H		
	setb TR0			;setup timer
	loopsie: 				;polling
		jb TF0, myexit	;exit if flag bit is 1
		jmp loopsie
	myexit:
		clr TF0			;clear flag bit
		ret

subtract:				;subroutine to perform subtraction of a 16 bit number from FFFFH 
	mov r0, 40H
	mov r1, 41H
	mov a, #0FFH
	subb a, r0
	mov 42H, a
	mov a, #00H
	subb a, r1
	mov 43H, a
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
		 DB   "Level 1",00H

my_string2:
         DB   "Level 2",00H

my_string3:
		 DB   "Level 3",00H

my_string4:
		 DB   "Level 4",00H

my_string5:
		 DB   "Value: ",00H
			 
end	
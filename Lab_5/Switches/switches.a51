org 0H
ljmp main

org 200H	
main:
	mov P2,#00h
	mov P1,#00h
	;initial delay for lcd power up
	;here1:setb p1.0
	acall delay
	;clr p1.0
	acall delay
	;sjmp here1
	acall lcd_init ;initialise LCD
	acall delay
	acall delay
	acall delay
	ljmp statezero

statezero:
	mov a,#82h		 ;Put cursor on first row,2 column
	acall lcd_command	 ;send command to LCD
	acall delay
	mov   dptr,#my_string1   ;Load DPTR with sring1 Addr
	acall lcd_sendstring	   ;call text strings sending routine
	acall delay
	mov a,#0C4h		  ;Put cursor on second row,4 column
	acall lcd_command
	acall delay
	mov   dptr,#my_string2
	acall lcd_sendstring
	setb P1.4
	setb P1.5
	setb P1.6
	setb P1.7
	call delay_1s
	ljmp stateonetofour

stateonetofour:
	;set up lcd
	mov a,#82h		 ;Put cursor on first row,2 column
	acall lcd_command	 ;send command to LCD
	acall delay
	mov   dptr,#my_string3   ;Load DPTR with sring1 Addr
	acall lcd_sendstring	   ;call text strings sending routine
	acall delay
	mov a,#0C4h		  ;Put cursor on second row,4 column
	acall lcd_command
	acall delay
	mov   dptr,#my_string2
	acall lcd_sendstring
	;state 1
	clr P1.4
	clr P1.5
	clr P1.6
	setb P1.7
	call delay_1s
	call delay_1s
	mov a,#0H
	call read_from_pins
	;state 2
	clr P1.4
	clr P1.5
	setb P1.6
	clr P1.7
	call delay_1s
	call delay_1s
	swap a
	call read_from_pins
	mov 30H,a
	;state 3
	clr P1.4
	setb P1.5
	clr P1.6
	clr P1.7
	call delay_1s
	call delay_1s
	mov a,#0H
	call read_from_pins
	;state 4
	setb P1.4
	clr P1.5
	clr P1.6
	clr P1.7
	call delay_1s
	call delay_1s
	swap a
	call read_from_pins
	mov 31H,a
	ljmp statefive

statefive:
	clr P1.4
	clr P1.5
	clr P1.6
	clr P1.7
	call ascii_finder_one
	call ascii_finder_two
	mov a,#82h		 ;Put cursor on first row,2 column
	acall lcd_command	 ;send command to LCD
	acall delay
	mov   dptr,#my_string5   ;Load DPTR with sring1 Addr
	acall lcd_sendstring	   ;call text strings sending routine
	acall delay
	mov a,#0C4h		  ;Put cursor on second row,4 column
	acall lcd_command
	acall delay
	mov   dptr,#my_string4
	acall lcd_sendstring
	call delay_1s
	call delay_1s
	mov a, 30H
	mov b, 31H
	mul ab
	mov 50H, b
	mov 51H, a
	mov 30H, b
	mov 31H, a
	call ascii_finder_one
	call ascii_finder_two
	mov a,#82h		 ;Put cursor on first row,2 column
	acall lcd_command	 ;send command to LCD
	acall delay
	mov   dptr,#my_string6   ;Load DPTR with sring1 Addr
	acall lcd_sendstring	   ;call text strings sending routine
	acall delay
	mov a,#0C4h		  ;Put cursor on second row,4 column
	acall lcd_command
	acall delay
	mov   dptr,#my_string4
	acall lcd_sendstring
	ljmp here
	here: ljmp here
	

read_from_pins:
	; msb P1.3 and lsb P1.0
	jnb P1.0, next1
	add a,#1H
	next1:
	jnb P1.1, next2
	add a,#2H
	next2:
	jnb P1.2, next3
	add a,#4H
	next3:
	jnb P1.3, next4
	add a,#8H
	next4:
	ret
	
;---------------------------------------------------------
ascii_finder_one:
	mov r1, 30H; the number
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
	ret

ascii_finder_two:
	mov r1, 31H; the number
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
				
; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

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
	 	 clr   a                 ;clear Accumulator for any previous data
	         movc  a,@a+dptr         ;load the first character in accumulator
	         jz    exit              ;go to exit if zero
	         acall lcd_senddata      ;send first char
	         inc   dptr              ;increment data pointer
	         sjmp  LCD_sendstring_loop    ;jump back to send the next character
exit:    pop 0e0h
         ret                     ;End of routine

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

delay_1s:
	mov r1,#200
	highlight:
	call delay_5ms
	djnz r1,highlight
	ret

delay_5ms:
	push 00h
	mov r0, #20
	h2: acall delay_250us
	djnz r0, h2
	pop 00h
	ret
	
delay_250us:
	push 00h
	mov r0, #244
	h1: djnz r0, h1
	pop 00h
	ret	

;--------------------------------------------------------
org 300H
my_string1:
		 DB   "Enter Inputs", 00H
my_string2:
         DB   "EE337-2022", 00H
my_string3:
		 DB   "Reading Inputs", 00H
my_string4:
		 DB   "Num1:",60H,61H,", Num2:",62H,63H
my_string5:
		 DB   "Computing Result", 00H
my_string6:
		 DB   "Result = ",60H,61H,62H,63H

end


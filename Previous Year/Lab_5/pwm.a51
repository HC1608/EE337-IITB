; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable
	
org 0H
jmp main
org 100H
main:
	mov TMOD, #01H		;set timer0 in mode 1
	mov P1, #0FH
	mov 42H, #03CH		
	mov 43H, #0B0H
	call delay
	call delay
	call lcd_init 		;initialise LCD
	call delay
	call delay
	mov a, P1
	anl a, #07H
	cjne a, #00H, not_zero
	mov 31H, #90H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #18H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_90
	not_zero:
	cjne a, #01H, not_one
	mov 31H, #80H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #16H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_80
	not_one:
	cjne a, #02H, not_two
	mov 31H, #70H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #14H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_70
	not_two:
	cjne a, #03H, not_three
	mov 31H, #60H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #12H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_60
	not_three:
	cjne a, #04H, not_four
	mov 31H, #50H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #10H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_50
	not_four:
	cjne a, #05H, not_five
	mov 31H, #40H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #08H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_40
	not_five:
	cjne a, #06H, not_six
	mov 31H, #30H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #06H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_30
	not_six:
	mov 31H, #20H
	call ascii_finder
	mov a,#83h		  			;Put cursor on first row,third column
	call lcd_command
	call delay
	mov dptr,#my_string1
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov a,#0C0h		  			;Put cursor on second row,third column
	call lcd_command
	call delay
	mov dptr,#my_string2
	call lcd_sendstring	    	;call text strings sending routine
	call delay
	mov 31H, #04H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	mov 31H, #00H
	call ascii_finder
	mov a,60H
	call lcd_senddata
	mov a,61H
	call lcd_senddata
	jmp duty_20

ascii_finder:
	push 1
	push 2
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
	pop 2
	pop 1
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

duty_90:
	setb P1.7
	mov r2, #18
	on_90:
		call delay_100ms
		djnz r2, on_90
	clr P1.7
	mov r2, #2
	off_90:
		call delay_100ms
		djnz r2, off_90
	jmp duty_90

duty_80:
	setb P1.7
	mov r2, #16
	on_80:
		call delay_100ms
		djnz r2, on_80
	clr P1.7
	mov r2, #4
	off_80:
		call delay_100ms
		djnz r2, off_80
	jmp duty_80

duty_70:
	setb P1.7
	mov r2, #14
	on_70:
		call delay_100ms
		djnz r2, on_70
	clr P1.7
	mov r2, #6
	off_70:
		call delay_100ms
		djnz r2, off_70
	jmp duty_70

duty_60:
	setb P1.7
	mov r2, #12
	on_60:
		call delay_100ms
		djnz r2, on_60
	clr P1.7
	mov r2, #8
	off_60:
		call delay_100ms
		djnz r2, off_60
	jmp duty_60

duty_50:
	setb P1.7
	mov r2, #10
	on_50:
		call delay_100ms
		djnz r2, on_50
	clr P1.7
	mov r2, #10
	off_50:
		call delay_100ms
		djnz r2, off_50
	jmp duty_50

duty_40:
	setb P1.7
	mov r2, #8
	on_40:
		call delay_100ms
		djnz r2, on_40
	clr P1.7
	mov r2, #12
	off_40:
		call delay_100ms
		djnz r2, off_40
	jmp duty_40

duty_30:
	setb P1.7
	mov r2, #6
	on_30:
		call delay_100ms
		djnz r2, on_30
	clr P1.7
	mov r2, #14
	off_30:
		call delay_100ms
		djnz r2, off_30
	jmp duty_30

duty_20:
	setb P1.7
	mov r2, #4
	on_20:
		call delay_100ms
		djnz r2, on_20
	clr P1.7
	mov r2, #16
	off_20:
		call delay_100ms
		djnz r2, off_20
	jmp duty_30

delay_100ms:
	mov r5, #4
	repeat:
		call delay_25ms
		djnz r5, repeat
		ret
		
delay_25ms:				;timer will take 50k/2MHz = 25,000us = 25ms
	mov TH0, 42H		;move the values to TH, TL register 
	mov TL0, 43H		
	setb TR0			;setup timer
	loop1: 				;polling
		jb TF0, exit	;exit if flag bit is 1
		jmp loop1
	exit:
		clr TF0			;clear flag bit
		ret

org 280H
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
	         jz    exitz              		;go to exit if zero
	         acall lcd_senddata      		;send first char
	         inc   dptr              		;increment data pointer
	         sjmp  LCD_sendstring_loop      ;jump back to send the next character
exitz:    pop 0e0h
         ret                     			;End of routine

;----------------------delay routine-----------------------------------------------------
delay:	 push 0
	 push 1
         mov r0,#1
loop2:	 mov r1,#255
	 loopsie:	 djnz r1, loopsie
	 djnz r0, loop2
	 pop 1
	 pop 0 
	 ret
;--------------------------------------------------------
org 350H
	
my_string1:
	DB   "Duty cycle:",00H

my_string2:
	DB   "Pulse width:",00H
		
end	
org 0H
jmp main
org 100H
	
main:
	mov TMOD, #01H		;set timer0 in mode 1
	mov P1, #00H		;configure as output
	mov 40H, #0C3H		;to set TH,TL = C350 (hex) = 50000 (dec)
	mov 41H, #50H		
	;mov 30H, #05H		;set the value of T
	call subtract		;load 2s complement into 42H and 43H
	forever:			;subroutine to produce turn on and off LEDs for T seconds each 
		call delay_Ts
		mov P1, #0FFH
		call delay_Ts
		mov P1, #00H
		jmp forever

delay_Ts:				;delay of T seconds is generated
	mov r3, 30H
	again:
		call delay_1s
		djnz r3, again
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
	loop1: 				;polling
		jb TF0, exit	;exit if flag bit is 1
		jmp loop1
	exit:
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
	
end	
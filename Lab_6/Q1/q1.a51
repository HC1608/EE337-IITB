org 0H
jmp main
org 100H
	
main:
	mov TMOD, #01H		;set timer0 in mode 1
	mov P1, #00H		;configure as output
	mov 40H,#0C3H		;to set maximum possible delay of 1
	mov 41H,#50H	
	call subtract		;load 2s complement into 42H and 43H
	forever:
		call delay_1s
		mov P1, #0FFH
		call delay_1s
		mov P1, #00H
		jmp forever


delay_1s:
	mov r2, #40
	repeat:
		call delay_33ms
		djnz r2, repeat
		ret

delay_33ms:
	mov TH0, 42H
	mov TL0, 43H
	setb TR0
	loop1: 
		jb TF0, exit
		jmp loop1
	exit:
		clr TF0	
		ret

subtract:
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
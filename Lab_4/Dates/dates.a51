org 0
sjmp main
org 100
main:
	mov 50H,#25H
	mov 51H,#06H
	mov 52H,#19H
	mov 53H,#83H
	loop:
		mov r0,#50H
		subloop:
		cjne r0,#53H,digit
		sjmp loop
		digit:
			mov a,@r0
			mov p1,a
			call twohundred
			swap a
			mov p1,a
			call twohundred
			mov r2, #255
			mov p1,r2
			call twohundred
			inc r0
			sjmp subloop
	
twohundred:
	mov r1,#200
	highlight:
	call delay_1ms
	djnz r1,highlight
	ret

delay_1ms:
	push 00h
	mov r0, #4
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
	
end
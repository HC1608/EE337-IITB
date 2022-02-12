org 0
sjmp main
org 100
main:
	mov 50H,#11H
	mov 51H,#07H
	mov 52H,#20H
	mov 53H,#02H
	loop:
		mov r0,#50H
		daymonth:
		//for DD/MM
		cjne r0,#52H,dmdigit
		sjmp year
		dmdigit:
			mov a,@r0
			mov p1,a
			call onethousand
			swap a
			mov p1,a
			call onethousand
			mov r2, #255
			mov p1,r2
			call onethousand
			inc r0
			sjmp daymonth
		year:
		// for YYYY
		cjne r0, #54H, ydigit
		mov r2, #255
		mov p1,r2
		call onethousand
		sjmp loop
		ydigit:
			mov a,@r0
			mov p1,a
			call onethousand
			swap a
			mov p1,a
			call onethousand
			inc r0
			sjmp year
			
onethousand:
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
	
end
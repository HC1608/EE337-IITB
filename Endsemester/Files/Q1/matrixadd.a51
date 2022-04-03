org 0h
ljmp main
org 50h

main:
	mov r2, 30H 	;store n
	mov a, r2
	mov b, r2
	mul ab			;get n^2
	mov r3, a		;store constant n^2
	mov r4, a		;store n^2 (moving)
	mov r5, #31H	;moving index
	loop:
		mov a, r5	
		mov r0, a	;make r0 the moving index
		mov a, r0	
		add a, r3	
		mov r1, a	;make r1 = [r0 + n^2]
		mov a, @r0	
		add a, @r1	;add M1[r0] + M2[r1]
		mov r6, a	;store the result in r6
		mov a, r1	
		add a, r3
		mov r0, a	;make r0 = [r0 + 2*n^2]
		mov a, r6	
		mov @r0, a	;move the result to M[r0] the new index
		inc r5		;increment the moving index
	djnz r4, loop	;do it until moving n^2 becomes 0
	
end	
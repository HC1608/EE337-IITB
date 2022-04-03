org 0000H
jmp main

org 0100H
main:
	mov r2, #0H				;r2 has max
	mov r3, #0H				;r3 has second max
	mov r0, #43H

loop:
	cjne r0, #3FH, continue 
	mov 70H, r3
	mov 71H, r2
	jmp finish
	
continue:
	mov a, @r0
	subb a, r3
	jmp neqr3
	
neqr3:
	jc lessthanr3
	mov a, @r0
	mov r3, a
	dec r0
	jmp loop
	
lessthanr3:
	clr c
	mov a, @r0
	subb a, r2
	jmp neqr2
	mov a, @r0
	mov r2, a
	dec r0
	jmp loop

neqr2:
	jc lessthanr2
	mov a, @r0
	mov r2, a
	dec r0
	jmp loop

lessthanr2:
	clr c
	dec r0
	jmp loop

finish:

end
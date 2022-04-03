org 0000H
jmp main
org 30H

main:
	mov r0, 50H
	call hex_to_decimal
	jmp finish
	
hex_to_decimal:
	mov a, r0
	push 1
	push 2
	mov b, #0AH
	div ab
	mov r1, b
	mov b, #0AH
	div ab
	mov r2, a
	mov a, b
	swap a
	add a, r1
	mov 53H, a
	mov 52H, r2
	pop 2
	pop 1
	ret

finish:
end
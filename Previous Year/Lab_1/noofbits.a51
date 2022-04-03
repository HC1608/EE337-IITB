org 0H
ljmp main
org 30H

main:
	mov a, 70H
	mov r0, #0H
	body:
		jb acc.0, increment_1
		jb acc.1, increment_2
		jb acc.2, increment_3
		jb acc.3, increment_4
		jb acc.4, increment_5
		jb acc.5, increment_6
		jb acc.6, increment_7
		jb acc.7, increment_8
		mov 71H, r0
	loop: jmp loop

increment_1:
	inc r0
	clr acc.0
	jmp body

increment_2:
	inc r0
	clr acc.1
	jmp body

increment_3:
	inc r0
	clr acc.2
	jmp body
	
increment_4:
	inc r0
	clr acc.3
	jmp body

increment_5:
	inc r0
	clr acc.4
	jmp body

increment_6:
	inc r0
	clr acc.5
	jmp body

increment_7:
	inc r0
	clr acc.6
	jmp body

increment_8:
	inc r0
	clr acc.7
	jmp body

end
	
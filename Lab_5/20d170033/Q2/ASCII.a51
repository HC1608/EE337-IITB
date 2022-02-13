org 0H
ljmp main
org 100H

main:
	call  ascii_finder

ascii_finder:
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
end
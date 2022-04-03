ORG 0H
LJMP MAIN
ORG 100H
MAIN:
CALL SEARCH
HERE: SJMP HERE
ORG 130H
SEARCH:
// Add your code here.
//30H has the starting index
//31H has the length
//32H has the element to be searched
//33H will have the index with the elements
MOV R3, 30H; register to store the starting index
MOV R2, 31H; register to store the length of array
SUBMAIN:; the main looping subroutine
CJNE R2,#0H,LOOP; check if the length of array is zero
//if length of the array is zero means element wasn't found
MOV 33H,#0EH; move 0EH to the address 33H
RET//exit the SEARCH subroutine
LOOP: ;if the length of the array is non zero
MOV A, R2; move the length to accumulator
SUBB A, #1H; make A = n-1
MOV B, #2H; make B = 2
DIV AB; divide (n-1) by 2
MOV R2, A; make the new length as (n-1)//2 (the quotient)
MOV A,R3; move the starting index to accumulator
ADD A,R2; add the new length to starting index as the (n-1)//2 equals the no of hops needed to reach the middle index
MOV R0,A; the address of middle index
MOV A,@R0; move the value stored in middle index to accumulator
CJNE A,32H,NOTEQUAL; compare the value with search element in 32H
//if found
MOV 33H, R0; move the found address to 33H
SJMP TERM; jump to the TERM subroutine
NOTEQUAL:
//check if middle val > search value(if carry is set to 1)
JC GREATER
//if lesser then nothing more to do, go back to SUBMAIN 
SJMP SUBMAIN
GREATER:
//if middle val >search val
MOV A, R0; move the middle index address to A
ADD A,#1H; add 1 to middle index address
MOV R3,A; make the new starting point as (middle index address + 1)
MOV A,B; take the remainder that we got while dividing (n-1) by 2
CJNE A,#0H,INCR; check if the remainder is 0, or n is odd
//if odd we don't have to do anything, go back to SUBMAIN
SJMP SUBMAIN
INCR:
//if even, then the length of right half of array is (n-1)//2 + 1
MOV A, R2; move (n-1)//2 into accumulator
ADD A,#1H; add 1 to (n-1)//2 
MOV R2,A; make new length as (n-1)//2 + 1 
SJMP SUBMAIN
//go back to SUBMAIN
TERM:
//we found the element
RET; exit the SEARCH subroutine
END
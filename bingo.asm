.include "SysCalls.asm"
.data
startmessage: .asciiz "Lets Play Bingo! Press anything but Enter to exit. Press Enter to get the next Bingo call:\n"
list:	.word	-31,-30,-29,-28,-27,-26,-25,-24,-23,-22,-21,-20,-19,-18,-17,-16,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32
randInt:	.space	6
newLine:	.asciiz	"\n"

.text
main:
la	$s0,	list
addi	$t1,	$zero,	61	#initialize i with 0
jal	swap			#jump to swap and save return address in $ra

la	$a0	startmessage	#Adds message to arguments
li	$v0	SysPrintString	#Prints argument to console
syscall

li	$v0,	SysReadChar
syscall
move 	$t0, 	$v0		#moves the input to the register $t0

add	$t1,	$zero,	$zero
beq	$t0,	10,	bingo	#checks if  input is equal to enter then proceeds to bingo to print calls



li	$v0	10		#exits the program
syscall


swap:
add	$a1,	$t1,	$zero	#Sets maximum to i
li	$v0	SysRandIntRange	#Generates a random integer
syscall
add	$t6,	$zero,	$a0	#Loads random integer result into $t6

add	$t7,	$t6,	$t6	#Doubles j index and stores in $t7
add	$t7,	$t7,	$t6	#Doubles j index to a total of 3x in $t7
add	$t7,	$t7,	$t6	#Doubles j index to a total of 4x in $t7
add	$t4,	$t7,	$s0	#Moves j spaces in the array and stores the value
lw	$s2,	0($t4)		#Loads list[j] in $s2

add	$t2,	$t1,	$t1	#Doubles index and stores in $t2
add	$t2,	$t2,	$t1	#Doubles index to a total of 3x in $t2
add	$t2,	$t2,	$t1	#Doubles index to a total of 4x in $t2
add	$t3,	$t2,	$s0	#Moves i spaces in the array and stores the value in $t3
lw	$s1,	0($t3)		#loads list[i] in $s1

sw	$s1,	0($t4)		#Switches s1 and s2
sw	$s2,	0($t3)

subi	$t1,	$t1,	1	#subtracts 1 from i
bgt	$t1,	0,	swap	#for i <= 32, loop again
jr	$ra			#jump back to main
	
bingo:
add	$t2,	$t1,	$t1	#Doubles index and stores in $t2
add	$t2,	$t2,	$t1	#Doubles index to a total of 3x in $t2
add	$t2,	$t2,	$t1	#Doubles index to a total of 4x in $t2
add	$t3,	$t2,	$s0	#Moves i spaces in the array and stores the value in $t6
lw	$t5,	0($t3)		#loads first index of list into $t6

add	$a0,	$t5,	$zero	#adds index to arguments
li	$v0	SysPrintInt	#prints the integer
syscall

la	$a0	newLine		#Adds newLine to arguments
li	$v0	SysPrintString	#Prints argument to console
syscall

addi	$t1,	$t1,	1
blt	$t1,	11,	bingo
j	main
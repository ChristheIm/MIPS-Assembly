# Kyungchan Im
# CST - 307
# 09/08/2022
# Multiplication in MIPS Assembly (Introducing QtSpim)
# In Class Exercise



# Variable Declaration
.data
	data1: .word 17
	data2: .word 29
	data3: .word 56

# All program cod is placed after the
# .test assembler directive
.text

# Declare main as a global function
.globl main



# The label main is the starting point
main:
	lw $t0, data1			# load word data1 (17) into reg $t0 	/ load immediate
	lw $t1, data2			# load word data2 (29) into reg $t1
	lw $t2, data3			# load word data3 (56) into reg $t2

	mul $t3, $t0, $t1		# multiply $t0 * $t1 = $t3 				/ result is only 32 bits
	mul $t3, $t3, $t2		# multiply $t3 * $t2 = $t3				/ final result stores in $t3
	move $a0, $t3			# move final result into arguments

	li $v0, 1				# print the value
	syscall
	
	li $v0, 10				# exit the value
	syscall

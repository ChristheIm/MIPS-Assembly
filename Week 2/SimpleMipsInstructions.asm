# Kyungchan Im
# CST - 307
# 09/13/2022
# Simple MIPS Instructions
# In Class Exercise

# A demonstration of some simple MIPS instructions
# Used to test QtSPIM

# All memory structures are placed at the .data assembler directive
# Variable Declaration
.data
	# The .word assembler directive reserves space
	# in memory for a single 4-byte word
	# and assigns that memory location and initial value
	value: .word 12			# Hex equivalent is 'c'
	Z: .word 0				# 



# Declare main as a global function
.globl main



# All program code is placed after the
# .text assembler directive
.text



# The label 'main' is the starting point
main:
	li $t2, 25				# Load immediate value (25), hex value = 19
	lw $t3, value			# Load word stored in 'value' 

	add $t4, $t2, $t3		# Result of addition will be in $t4
	sub $t5, $t2, $t3		# Result of subtraction will be in $t5
	
	sw $t5, Z				# Take the result of $t5 and store in Z
	
	# Exit the program by means of a syscall
	li $v0, 10				# Set $v0 to "10" to select exit syscall
	syscall
	
	
	
# Kyungchan Im
# CST - 307
# 09/13/2022
# Week 2 Class Exercise
# In Class Exercise

# A demonstration of some simple MIPS instructions
# Used to test QtSPIM

# All memory structures are placed at the .data assembler directive
# Variable Declaration
.data
	# The .word assembler directive reserves space
	# in memory for a single 4-byte word
	# and assigns that memory location and initial value
	value: .word 12				# Hex equivalent is 'c'
	Z: .word 0					# Stored 0 in Z 
	msg: .asciiz "25 + 12 = "	# Print the text purpose
	next_line: .asciiz "\n"		# Print the next line
	msg2: .asciiz "25 - 12 = " 	# Print the second requirement message



# Declare main as a global function
.globl main



# All program code is placed after the
# .text assembler directive
.text



# The label 'main' is the starting point
main:
	li $t2, 25					# Load immediate value (25), hex value = 19
	lw $t3, value				# Load word stored in 'value' 

	add $t4, $t2, $t3			# Result of addition will be in $t4
	sub $t5, $t2, $t3			# Result of subtraction will be in $t5
	
	sw $t5, Z					# Take the result of $t5 and store in Z

	# Print out the text
	li $v0, 4					# load immediate - Code for syscall (puts in your console) : print string
	la $a0, msg					# Load address of the msg given under .data
	syscall
	
	
	move $a0,$t4            	# Change the register address to print out the answer
    li $v0,1                	# Load immediate code for printing integer
    syscall
	
	la $a0, next_line			# Assign next_line into the $a0 to print out the next line
	li $v0, 4					# Syscall for printing string
	syscall

	la $a0, msg2				# Load address of the second message given under .data
	li $v0, 4					# syscall method for printing string
	syscall
	
	move $a0, Z					# move address register to point the result of '25-12'
	li $v0, 1					# to print the integer
	syscall
	
	
	# Exit the program by means of a syscall
	li $v0, 10					# Set $v0 to "10" to select exit syscall
	syscall
	

	
	
	
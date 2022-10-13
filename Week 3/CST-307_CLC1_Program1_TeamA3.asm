# Alejandro Miller, Colby Paulson, John Haviland, Kyungchan Im
# CST-307
# 10/02/2022
# CLC 1 - Program 1
# Adding two user-inputted integers together and printing result.

# ---------------------------------------------------------------------------------------------------------------------------------------------------
# Variable Declaration
.data

	firstNumber_msg:	.asciiz	"Enter first number: "		# first number prompt for user
	secondNumber_msg:	.asciiz	"Enter second number: "	# second number prompt for user
	sum_msg:		.asciiz	"Sum: "			# sum result
	newLine:		.asciiz 	"\n"

# ---------------------------------------------------------------------------------------------------------------------------------------------------
# Program code placed after text assembler directive
.text

# Declare main as global function
.globl main

# ---------------------------------------------------------------------------------------------------------------------------------------------------
main:
	# Print firstNumber_msg
	
	li	$v0, 4				# print string, syscall code = 4
	la	$a0, firstNumber_msg		# load string asking for first number to print
	syscall					# execute command

	# Read first number from user input

	li	$v0, 5				# read int, syscall code = 5
	syscall					# execute command
	move	$t0, $v0			# move number from user input to $t0

	# Print secondNumber_msg

	li	$v0, 4				# print string, syscall code = 4
	la	$a0, secondNumber_msg	# load string asking for second number to print
	syscall					# execute command

	# Read second number from user input

	li	$v0, 5				# read int, syscall code = 5
	syscall					# execute command
	move	$t1, $v0			# move number from user input to $t1

	# Adding the two numbers and printing sum message

	add	$t2, $t0, $t1			# add $t0 + $t1 = $t2
	li	$v0, 4				# print string, syscall code = 4
	la	$a0, sum_msg			# load sum message string to print
	syscall					# execute command

	# Printing sum
	
	li	$v0, 1				# print int, syscall code = 1
	la	$a0, ($t2)			# putting the sum of $t0 & $t1 into address $a0
	syscall					# execute command

	# Exit program

	li	$v0, 10			# exit program, syscall code = 10
	syscall					# execute command

# ---------------------------------------------------------------------------------------------------------------------------------------------------
	

	

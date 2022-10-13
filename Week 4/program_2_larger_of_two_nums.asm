# Alejandro Miller, Colby Paulson, John Haviland, Kyungchan Im
# CST - 307
# 10/01/2022
# CLC - Program 2
# Larger of two numbers
###################################################################################################################
# Variable Declaration
.data
	# variable declaration for messages and strings
	first_num_msg: 		.asciiz "Enter first number: "
	second_num_msg: 	.asciiz "Enter second number: "					
	result_msg: 		.asciiz "Larger number is: "
	lf:     .asciiz "\n"
	


###################################################################################################################
# Start with .text first
.text

# Define the global main where the program starts
.globl main



###################################################################################################################
		# Registers #
	# $t0 – to hold the first number
	# $t1 – to hold the second number
	# $t2 – to hold the larger of $t0 and $t1



###################################################################################################################
main:
	# Print the first message
	li $v0, 4										# Print string syscall | code = 4
	la $a0, first_num_msg							# Ask the user to enter first number to compare
	syscall											# Execute the question string to be displayed
	
	# Get first number from user and save it
	li $v0, 5										# Read integer syscall | code = 5
	syscall											# Executes the read from console
	move $t0, $v0									# move the first_number from the $v0 register to $t0
	


	# Print the second message
	li $v0, 4										# Print string syscall | code = 4
	la $a0, second_num_msg							# Ask the user to enter second number to compare
	syscall											# Execute the question string to be displayed
	
	# Get first number from user and save it
	li $v0, 5										# Read integer syscall | code = 5
	syscall											# Executes the read from console
	move $t1, $v0									# move the second_number from the $v0 register to $t1



###################################################################################################################
		# Comparison #
	
	bne $t0, $t1, COMPARE							# If t0 != t1, go to COMPARE function
	j EQUAL											# else, execute EQUAL function


	COMPARE:										# if t0 > t1, execute FIRST function
		bgt $t0, $t1, FIRST							# else, t1 > t0 is true, so execute SECOND function
		bgt $t1, $t0, SECOND


	EXIT:											# Function for exiting program
		# Print the result
		li $v0, 4										# Print string syscall | code = 4
		la $a0, lf										# print the result message	
		syscall

		li $v0, 10										# Exit the program
		syscall




###################################################################################################################
	# Operations #
	
	# First number will be the result
	FIRST:
		move $t2, $t0									# Since t0 > t1, store the result value to $t2
		li $v0, 4										# Print string syscall | code = 4
		la $a0, result_msg								# print the result message
		syscall											# Execute the question string to be displayed

		# Print the result
		li $v0, 1
		move $a0, $t2									# move $a0 value from result_msg to result value
		syscall											# which is $t2
		
		j EXIT											# once function is over, exit the program


	# Second number will be the result
	SECOND:
		move $t2, $t1									# Since t1 > t0, store the result value to $t2
		li $v0, 4										# Print string syscall | code = 4
		la $a0, result_msg								# print the result message
		syscall											# Execute the question string to be displayed

		# Print the result
		li $v0, 1
		move $a0, $t2
		syscall

		j EXIT											# once function is over, exit the program


	# Both of the numbers are equal, so print either one
	EQUAL:
		move $t2, $t0									# Since t0 = t1, store any value to $t2
		li $v0, 4										# Print string syscall | code = 4
		la $a0, result_msg								# print the result message
		syscall											# Execute the question string to be displayed

		# Print the result
		li $v0, 1
		move $a0, $t2
		syscall	

		j EXIT											# once function is over, exit the program


# End of Program
###################################################################################################################
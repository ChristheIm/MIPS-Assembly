# Kyungchan Im
# CST - 307
# 09/20/2022
# Simple routine to demo a loop (use cache memory)
###################################################################################################################
# Variable Declaration
.data
	# variable declaration for messages and strings
	msg1: 	.asciiz "Number of Integers (N)?: "						
	msg2: 	.asciiz "Sum = "
	lf:     .asciiz "\n"
	

###################################################################################################################
# Start with .text first
.text

# Define the global main where the program starts
.globl main
main:
	# Print the message
	li $v0, 4										# Print string syscall code = 4
	la $a0, msg1									# Ask the user to enter an int
	syscall											# Execute the string to be displayed
	


	# Get N from user and save it
	li $v0, 5										# Read integer syscall code = 5
	syscall											# Executes the read from console
	move $t0, $v0									# move the user_input from the $v0 register to $t0
	
	

	# Initialize registers
	li $t1, 0										# Initialize counter (i)
	li $t2, 0										# Initialize sum
	
	

	# Main loop body
	loop: 
		addi $t1, $t1, 1							# i = i + 1
		add $t2, $t2, $t1							# sum = sum + i
		beq $t0, $t1, exit							# if $t1 = $t0, then exit the loop else, continue the loop function
		j loop

	# Exit routine - print msg2
	exit:
		li $v0, 4									# Print string syscall code = 4
		la $a0, msg2								# Print the "Sum"
		syscall
	
	# Print the sum
	li $v0, 1										# Print an int using code = 1
	move $a0, $t2
	syscall

	
	# Print newline
	li $v0, 4										
	la $a0, lf
	syscall

	
	# Exit the program
	li $v0, 10										# Exit the program
	syscall
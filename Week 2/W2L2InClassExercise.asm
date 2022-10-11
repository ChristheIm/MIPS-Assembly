# Kyungchan Im
# CST - 307
# 09/15/2022
# Week 2 Lesson 2 Exercise
# In Class Exercise
###################################################################################################################
# This is a simple program to take two numbers from the user
# and perform basic arithmetic such as addition, subtraction, multiplication
# This is my work with the help of Sweetcode


###################################################################################################################
# Program Flow:
# 1. Print statements to ask the user to enter two different numbers
# 2. Store the two numbers in different registers and print the 'menu'
# 	 of arithmetic instructions to the user.
# 3. Based on the choice made by the user, create branch statements
#	 to perform the commands and print the results
# 4. Exit the program 


###################################################################################################################
# Variable Declaration
.data
	# variable declaration for prompts and strings
	prompt1: 	.asciiz "Enter the first number: "						
	prompt2: 	.asciiz "Enter the second number: "
	menu:    	.asciiz "Enter the number associated with the operation: \n1=> add \n2=> subtraction \n3=> multiply: "
	result_txt: .asciiz "Your final result is: "


###################################################################################################################
# Let's run with scissors and be dangerous
# Start with .text first
.text

# Declare main as a global and starting point for our program
.globl main
main:
	# The following block of code is to pre-load the integer values
	# representing the various instructions into registers for storage
	li $t3, 1								# This loads immediately the value 1 in the temp reg 3
	li $t4, 2								# Same logic applies for temp reg 4 and 5
	li $t5, 3	
	


	# Ask the user to provide the first number 
	li $v0, 4								# Command for printing a string
	la $a0, prompt1							# Loading the string to print (use la because we want to access to the memory where prompt1 is located)
	syscall									# execute the command

	# The next block of code is for reading the first number
	li $v0, 5								# Command for reading an integer
	syscall									# Execute the command for reading
	move $t0, $v0							# Moving the number read from user input to $t0



	# Asking the user to provide the second number
	li $v0, 4								# Command for printing a string
	la $a0, prompt2							# Loading the string into the argument $a0
	syscall									# Execute the command

	# Reading the second number to be provided by the user
	li $v0, 5								# Command for reading an integer immediate
	syscall									# Execute the command for reading
	move $t1, $v0							# Moving the number read from user input to $t1



	# The next block of code is to print all the commands the user
	# can take with regards to the two numbers that have been provided
	li $v0, 4								# Command for printing a string
	la $a0, menu							# Loading the string to print the menu
	syscall
	
	# The next block of code is to read the number by the user
	li $v0, 5								# Command for reading an integer immediate
	syscall									# Waiting for the user to enter a number
	move $t2, $v0							# Moving the number read from user input to $t2


###################################################################################################################
	# The following lines of code determine what should take place
	# Depending on the int value that was provided by the user
	beq $t2, $t3, addProcess 				# Branch to "addProcess" if $t2 = $t3
	beq $t2, $t4, subtractProcess
	beq $t2, $t5, multiProcess


	# addProcess -> labeled instruction 
	addProcess:
		add $t6, $t0, $t1
		
		li $v0, 4
		la $a0, result_txt
		syscall

		li $v0, 1
		la $a0, ($t6)
		syscall
		
		li $v0, 10
		syscall

	# subtractProcess -> labeled instruction 
	subtractProcess:
		sub $t6, $t0, $t1
		
		li $v0, 4
		la $a0, result_txt
		syscall

		li $v0, 1
		la $a0, ($t6)
		syscall
		
		li $v0, 10
		syscall

	# multiProcess -> labeled instruction 
	multiProcess:
		mul $t6, $t0, $t1
		
		li $v0, 4
		la $a0, result_txt
		syscall

		li $v0, 1
		la $a0, ($t6)
		syscall
		
		li $v0, 10
		syscall




















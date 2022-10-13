# Alejandro Miller, John Haviland, Colby Paulson, Kyungchan Im
# CST-307
# 10/09/22
# Program that takes in a string and determines if it is a palindrome or not.
# This is our work with the assistance of Professor Hughes
#-----------------------
# Define Variables
.data
  prompt: .asciiz "Enter a string: "
  notpal: .asciiz "This is not a palindrome"
  pal:    .asciiz "This is a palindrome"
  string_space:         .space 20				# .space Length directive
							# instructs the assembler to
							# reserve length of bytes.
							# As every word has 4 bytes, when len is 20
							# we are reserving 5 words.
# Constants (System call code constants)
SYS_PRINT_STRING	= 4
SYS_EXIT			= 10
SYS_GET_STRING		= 8
STRING_LEN			= 20
#--------------------------------------
# Registers:
# $t1: pointer to first location in memory of string input
# $t2: loop index for loops
# $t3: holds one character from the string
# $t5: length of string (valid after end_length_loop)
# $sp: pointer to stack. Initial value is 0x7ffff500


#--------------------------------------
# Main Code
.text
.globl main
main:

  # Ask user for input
  la $a0, prompt					# base address in $a0
  li $v0, SYS_PRINT_STRING
  syscall

  # Read in the string from user
  # Syscode 8, base address is in $a0, length in $a1
  la $a0, string_space 						# Pointer to memory location that holds string
  li $a1, STRING_LEN					# Space allocated for string
  li $v0, SYS_GET_STRING
  syscall

  # Load string in both $t1 and $t2 (pointers to the first location in memory of our string)
  la $t1, string_space
  la $t2, string_space

  # Count the number of characters in the string (bytes)
  # Use $t5 as counter to find length
  li $t5, 0

#Loop through inputted string to get length
length_loop:
  lb   $t3, ($t2)						# Loading a byte from base address
  beqz $t3, end_length_loop				# If $t3 == 0 (end of string), jump
  addu $t2, $t2, 1					# Increment $t2 by 1
  add  $t5, $t5, 1
  b    length_loop					# branch to length loop (b vs. j)

end_length_loop:
  sub $t5, $t5, 1					# remove the newline character
  jal store_stack					# Jump-and-Link to save the program counter in $ra
  jal check_palindrome
#-------------------------------------------------------


exit:
  addi $v0, $0, SYS_EXIT
  syscall

#-------------------------------------------------------
# Functions go here
#-------------------------------------------------------
# Store the string in the stack
store_stack:
	# $t5 has count number to iterate string
	sub $sp, $sp, $t5		# Allocate stack space (in our case we are allocating
					# bytes, not words, so we move the pointer $t5 bytes back)
	li $t6, 0			# Used to increment through our string
	add $t1, $t1, $t5		# Change pointer to end of string

stack_loop:
	lb $t4, -1($t1)			# Load a byte at a time (one char)
	sb $t4, -1($sp)			# STORE TO MAIN MEMORY. Since we are not loading a word at a time, we need
					# to use -1 instead of 0 for offset
	sub  $sp, $sp, 1
	sub  $t1, $t1, 1		# Pointer to our string location
	addi $t6, $t6, 1
	bne $t5, $t6, stack_loop	# If the counter == str len, branch

stack_done:
	jr $ra				# return to caller's code

#--------------------------------------------------------
	
	# $t5 is length of string
	# $sp is pointer in stack of first char 'B' of Bill

check_palindrome:
	li $s0, 2			# This is just used to test and verify the code is reaching here
	
	
	move $t8, $sp			# $t8 is our "forwards" iterator
	move $t9, $sp			# $t9 is our "backwards" iterator
	add $t9, $t9, $t5
	sub $t9, $t9, 1 
	
checker_loop:
	
	lb $t6, 0($t8)			# Get the character from stack at address $t8
	lb $t7, 0($t9)			# Get the character from stack at address $t9
	
	bne $t6, $t7, not_palindrome	# Comparison. If not equals, break
	
	addi $t8, $t8, 1		# Increment forwards iterator
	sub  $t9, $t9, 1		# Decrement backwards iterator
	
	beq $t8, $t9, palindrome	# Iterator comparison. If indies are equivalent, break
	
	j checker_loop			# Continue
	
	
not_palindrome:

	la $a0, notpal			# Prepare a syscall to print string "not palindrome"
	li $v0, SYS_PRINT_STRING	# Preparation
	syscall

	jr $ra				# Jump back to where we jal'd

palindrome:

	la $a0, pal			# Prepare a syscall to print string "palindrome"
	li $v0, SYS_PRINT_STRING	# Preparation
	syscall

	jr $ra				# Jump back to where we jal'd
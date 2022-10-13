# Kyungchan Im
# CST-307
# 10/06/22
# Sample Code
# This is my work
#-----------------------------------------
# Define Variables
.data
	prompt:			.asciiz	"Enter a string: "
	string_space:	.space		20						# .space Length directive
														# instructs the assembler to
														# reserve length of bytes.
														# As every word as 4 bytes, when len is 20
														# we are reserving 5 words.
# Constants (System call code constants)
SYS_PRINT_STRING	= 4
SYS_EXIT			= 10
SYS_GET_STRING		= 8
STRING_LEN			= 20
#---------------------------------------------
# Main Code
.text
.globl main

main:
		# Ask the user for input
		la		$a0, prompt						# base address in $a0
		li		$v0, SYS_PRINT_STRING
		syscall

		# Read in the string from user
		# Syscode 8, base address is in $a0, length in $a1
		la		$a0, string_space  		# Pointer to memory location that holds string
		li		$a1, STRING_LEN				# Space allocated for string
		li		$v0, SYS_GET_STRING
		syscall

		# Load string in both $t1 and $t2 (pointers to the first location in memory of our string)
		la	$t1, string_space
		la	$t2, string_space

		# Count how many chars are in the string (bytes)
		# Use $t5 as counter to find length
		li	$t5, 0

length_loop:
		lb	$t3, ($t2)					# Loading a byte from base address
		beqz	$t3, end_length_loop	# If $t3 = 0 jump
		addu	$t2, $t2, 1				# inc $t2 by 1
		add	$t5, $t5, 1
		b	length_loop					# branch to length loop

end_length_loop:
		sub	$t5, $t5, 1					# remove the newline character
		jal	store_stack					# Jump-and-Link to save the program counter in $ra
										# This saves the return address in $ra
		jal get_stack
#-----------------------------------------------------------------------		


exit:
		addi 	$v0, $0, SYS_EXIT
		syscall

#----------------------------------------------------------------------
# Functions go here
#----------------------------------------------------------------------
# Store the string in the stack
store_stack:
		# $t5 has count number to iterate string 
		sub $sp, $sp, $t5				# allocate stack space (in our case we are allocating 
										# bytes not words)
		li $t6, 0						# used to increment through string
		add $t1, $t1, $t5				# change pointer to end of string

stack_loop:
		lb $t4, -1($t1)					# Load a byte at a time (one char)
		sb $t4, -1($sp)					# Since we are not loading a word at a time, we need
										# to use -1 instead of 0 for offset
		sub $sp, $sp, 1					
		sub $t1, $t1, 1					# Pointer to string location
		add $t6, $t6, 1				
		bne $t5, $t6, stack_loop		# If the counter = string len, branch

stack_done:
		jr $ra							# return to caller's code

#----------------------------------------------------------------------

	# $t2 is a pointer of memory location for last char
	# $t1 pointer of memory location of last char
	# $sp pointer in stack of first char 'B' of Bill
	# reverse the string and put back on stack

get_stack:
		li $s0, 2						# This is just used to test and verify the code is reaching here

		# Get the last char 'l'
		lb $t7, 3($sp)
		sb $t7, 5($sp) 					# Cannot use -5 since that would grow the stack

		# Get the third char 'l'
		lb $t7, 2($sp)
		sb $t7, 6($sp)	

		# Get the second char 'i'
		lb $t7, 1($sp)
		sb $t7, 7($sp)

		# Get the first char 'B'
		lb $t7, 0($sp)
		sb $t7, 8($sp)		




#######################################################################
# $t1				# position of string in memory
# $t2 

# $t3				# holds one byte
# $t4				# holds bytes to be put on stack

# $t5				# Len of strength
# $t6				# iterate string





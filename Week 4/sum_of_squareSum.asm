# Kyungchan Im
# CST - 307
# 09/29/2022
# Example program to compute sum of squares.
# In Class Exercise
###################################################################################################################
# Variable Declaration
.data
	# creating an array for this program
	array:	.word 23, -2, 45, 67, 89, 12, -100, 9, 120, 6
	arrend:											# Contains the memory location for the end of array

	sumMessage:	.asciiz		"The sum of the array is: "
	squareMessage:  .asciiz		"The sum of the squares is: "
	newLine:		.asciiz		"\n"



###################################################################################################################
  # Summary of program
  # array = {23, -2, 45, 67, 89, 12, -100, 9, 120, 6}
  # the sum of the integers is 0
  # the square sum of the integers is 0

  # Algorithm being implemented to sum an array
  # sum = 0 (use $t0 for sum)
  # squareSum = 0 ($t5 for squareSum)
  # for i = 0 to length - 1 do (use $t1 to keep track of i)
  # sum = sum + array[i] (use $t2 for length - 1)
  # squareSum = squareSum + array[i]*array[i]
  # end for (use $t3 for base address of array)

  # registers
  # $t0 -- sum
  # $t5 -- squareSum
  #
  # $t3 -- pointer to current array element
  # $t2 -- pointer to end of array
  #  
  # $t4 -- current value fetched from array
  # $t6 -- temp to hold squared value



###################################################################################################################
# All program code is place after the text assembler directive
.text

# Declare main as a global function
.globl main

# Label main is the starting point
main:
									# Terminology:
									# li     --> Assembly Language Opcode - actual operation to be performed by the CPU
									# li     --> mnemonic - abbreviation for the operation (load immediate)
									# $t0,0  --> Operand - value or argument on which the Opcode operates

	li $t0, 0						# sum = 0
	li $t5, 0						# squareSum = 0
	
	la $t3, array					# load base address of array
	la $t2, arrend					# load address of array end
	j test							# jump to target label test



###################################################################################################################
  # Loop Function #
loop:
	lw $t4, 0($t3)					# load array[i] = most current element
	addi $t3, $t3, 4				# increment array pointer
									# The addi instructions performs an addition on both the source registers
									# contents and immediate data, and stores the result in the destination reg.
	add $t0, $t0, $t4				# update sum 
	mul $t6 $t4, $t4				# get val * val = square value
	add $t5, $t5, $t6				# update squareSum    



###################################################################################################################
  # Test Function #
test:
	blt $t3, $t2, loop				# more to do? If yes, loop
									# Branch Less Than if $t3 < $t2


###################################################################################################################
  # exit #

exit:
	# print the message for result
	li $v0, 4						# Prepare syscall for displaying string | code = 4 
	la $a0, sumMessage				
	syscall							# Execute the command

	# print the value of the sum
	li $v0, 1						# Prepare syscall for displaying int | code = 1
	addi $a0, $t0, 0				# move into $a0 from  $t0
	syscall

	# print the newline
	li $v0, 4						# Prepare syscall for displaying string | code = 4 
	la $a0, newLine				
	syscall							# Execute the command

    # print the message for squareSum
	li $v0, 4						
	la $a0, squareMessage				
	syscall

	# print the value of the squareSum
	li $v0, 1						
	addi $a0, $t5, 0				
	syscall


	# Exit
	li $v0, 10						# Prepare syscall for exit | code = 10
	syscall



# end of program
###################################################################################################################
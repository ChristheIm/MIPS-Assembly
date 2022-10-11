# Kyungchan Im
# CST - 307
# 09/08/2022
# Subtraction in MIPS Assembly (Introducing QtSpim)
# In Class Exercise



# Variable Declaration
.data
    x: .word 23			# word means the number of bits that can be transfered at one time
	y: .word 47			# variable y is set to 47
	
# All program cod is placed after the
# .test assembler directive
.text

# Declare main as a global function
.globl main



# The label main is the starting point
main:
	lw $t0, x			# lw load word/      loads int 23 into reg $t0/		Memory to register
	li $t1, 35			# li load immediate/ loads int 35 into reg $t1/		Loads immediate value into register
	lw $t2, y			# put the value of y (int 47) into reg $t2
	
	sub $t3, $t0, $t1 	# subtract $t0 - $t1 = $t3
	sub $t3, $t3, $t2	# subtract $t3 - $t2 = $t3/ 		$t3 has final result
	move $a0, $t3		# move final result into $a0/		Copy from register to register.
	
	li $v0, 1			# prepare syscall to print it (1 for integer)
	syscall				# prints the result
	
	li $v0, 10			# prepare syscall to exit (10 for exit)
	syscall				# exit
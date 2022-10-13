# Benchmark-Cache-Performance-Analysis.asm
#-------------------------------------------------
# Author: William B Hurst
# Creation date: 2019Sep18
#-------------------------------------------------
# this is a simple program that demonstrates
# how a computer system that utilizes 4-Byte Words
# can have significantly different Performance
# characteristics based on whether it uses
# Main Memory and Cache Data Transfer configurations of:
#
# 1) One Block Word
# 2) Four Block Words
# 3) Non-Burst
# 4) Burst
#
# from a computer system that utilizes:
#
# *)  4 byte words
#------------------------------------------------- 
# the system has the following characteristics
#-------------------------------------------------
#        Observed Miss Penalty Rates of
#-------------------------------------------------
# *)  1 Clock Cycle to Read from Main Memory
# *)  3 clock Cycles to transfer the 4 blocks of data
#-------------------------------------------------
#
# The program asks the user to input:
#
# *) One  word block miss penalty rate
# *) Four word block miss penalty rate
#
#-------------------------------------------------
# the data will be stored as follows in the program:
#
# 	$t0 - used to hold the first number
# 	$t1 - used to hold the second number
# 	$t2 - used to hold multiplication of $t0 * $t1
#-------------------------------------------------
# Declaration of .text and main
# Set main as global declaration
	.text
	.globl	main
main:
	#----------------------------------------------------------------------
	li	$v0, 4										# Prepare syscall for print
	la	$a0, programDesc							# assign address value on $a0 --> ProgramDesc
	syscall											# syscall print
	#----------------------------------------------------------------------
	li	$v0, 4										# Prepare syscall for print
	la	$a0, oWMissRateReq							# assign address value on $a0 --> oWMissRateReq
	syscall											# syscall print
	#----------------------------------------------------------------------
	li	$v0, 6										# Prepare syscall for reading a float value |code 6 = reading a float
	syscall											# syscall reading a float
	#----------------------------------------------------------------------
	s.s	$f0, oWordMissRate							# # store word from $f0 into address oWordMissRate
	#----------------------------------------------------------------------
	li	$v0, 4										# Prepare syscall for print
	la	$a0, fWMissRateReq							# assign address value on $a0 --> fwMissRateReq
	syscall						
	#----------------------------------------------------------------------
	li	$v0, 6										# Prepare syscall for reading a float value
	syscall											# syscall 
	#----------------------------------------------------------------------
 	s.s	$f0, fWordMissRate							# store word from $f0 into address fWordMissRate
	#----------------------------------------------------------------------
	# perform the intended operation - multiply 
	#  Miss_Penalty_ave = (Miss_Penalty_rate)(Miss_Penalty_Cycles)
	#----------------------------------------------------------------------
	# One Word Miss Penalty Calculations
	#----------------------------------------------------------------------
	l.s	$f0, oWordMissRate							# load word into $f0 from address oWordMissRate
	l.s	$f1, oWordMissCTime							# load word into $f1 from address oWordMissTime
	mul.s	$f2, $f0, $f1							# Multiply two float point and result to one.
	s.s	$f2, oWordMissAve							# store word from $f2 into address oWordMissAve
	#----------------------------------------------------------------------
 	li	$v0, 4										# Prepare syscall for print
	la	$a0, oWordMissCalcOut						# assign address value on $a0 --> oWordMissCalcOut
	syscall											# Execute the syscall
	#----------------------------------------------------------------------
 	li	$v0, 4										# Same step follows
	la	$a0, oWordMissRateOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Prepare syscall for print float | code 2 = print float
	l.s	$f12, oWordMissRate							# load float into $f12 from address oWordMissRate
	syscall											# Execute
	#----------------------------------------------------------------------
	li	$v0, 4										# Prepare printing oWordMissCTimeOut
	la	$a0, oWordMissCTimeOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Prepare syscall for printing float
	l.s	$f12, oWordMissCTime						# load float into $f12 from address oWordMissCTime
	syscall				
	#----------------------------------------------------------------------
	li	$v0, 4										# Same process code 4 = printing string
	la	$a0, oWordMissAveOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Process for printing float stored in the oWordMissAve address
	l.s	$f12, oWordMissAve				
	syscall				
	#----------------------------------------------------------------------
	# Four Word (Non-Burst) Miss Penalty Calculations
	#----------------------------------------------------------------------
	l.s	$f0, fWordMissRate							# Store the result of multiplied float value into nbfWordMissAve($f2)
	l.s	$f1, nbfWordMissCTime						# Multiplication = fWordMissRate * nbfWordMissCTime
	mul.s	$f2, $f0, $f1		
	s.s	$f2, nbfWordMissAve	
	#----------------------------------------------------------------------
 	li	$v0, 4										# Print the string stored in the nbfWordMissCalcOut
	la	$a0, nbfWordMissCalcOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 4										# Print the string stored in the nbfWordMissRateOut
	la	$a0, nbfWordMissRateOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Print the float stored in fWordMissRate
	l.s	$f12, fWordMissRate	
	syscall				
	#----------------------------------------------------------------------
	li	$v0, 4										# Print the string stored in the nbfWordMissCTimeOut
	la	$a0, nbfWordMissCTimeOut  
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Print the float stored in nbfWordMissCTime
	l.s	$f12, nbfWordMissCTime	
	syscall				
	#----------------------------------------------------------------------
	li	$v0, 4										# Print the string stored in nbfWordMissAveOut
	la	$a0, nbfWordMissAveOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Print the float stored in nbfWordMissAve
	l.s	$f12, nbfWordMissAve	
	syscall				
	#----------------------------------------------------------------------
	# Four Word (Burst) Miss Penalty Calculations
	#----------------------------------------------------------------------
	l.s	$f0, fWordMissRate							# Store the result of multiplied float value into bfWordMissAve($f2)
	l.s	$f1, bfWordMissCTime						# Multiplication = fWordMissRate * bfWordMissCTime
	mul.s	$f2, $f0, $f1		
	s.s	$f2, bfWordMissAve	
	#----------------------------------------------------------------------
 	li	$v0, 4										# Print the string stored in bfWordMissCalcOut address
	la	$a0, bfWordMissCalcOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 4										# Print the string stored in bfWordMissRateOut address
	la	$a0, bfWordMissRateOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Print the float stored in fWordMissRate address
	l.s	$f12, fWordMissRate	
	syscall				
	#----------------------------------------------------------------------
	li	$v0, 4										# Print the string stored in bfWordMissCTimeOut address
	la	$a0, bfWordMissCTimeOut  
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Print the float stored in bfWordMissCTime address
	l.s	$f12, bfWordMissCTime	
	syscall				
	#----------------------------------------------------------------------
	li	$v0, 4										# Print the string stored in bfWordMissAveOut address
	la	$a0, bfWordMissAveOut	
	syscall				
	#----------------------------------------------------------------------
 	li	$v0, 2										# Print the float stored in bfWordMissAve address
	l.s	$f12, bfWordMissAve	
	syscall					
	#----------------------------------------------------------------------
	li	$v0, 4										# PRint the string stored in theEnd address
	la	$a0, theEnd		
	syscall				
	#----------------------------------------------------------------------
	li	$v0, 10										# Prepare syscall for terminate the program | code 10 = Exit
	syscall											# Execute
	#----------------------------------------------------------------------
	.data
#-----------------------------------
oWordMissRate:		.float	0.12
oWordMissCTime:		.float	5.0			# place answer to a here. 			Question A
oWordMissAve:		.float	0.6
#-----------------------------------
fWordMissRate:		.float	0.07
#-----------------------------------
nbfWordMissCTime:	.float	20.0			# place answer to b here.		Question B
nbfWordMissAve:		.float	1.4
#-----------------------------------
bfWordMissCTime:	.float	8.0			# place answer to c here.		Question C
bfWordMissAve:		.float	0.56
#-----------------------------------------------------------------------------
programDesc:		.asciiz "This program is designed to demonstrate 
\n'Benchmark Cache Performance Impacts' through the 'Cache Miss Penalty Variances' 
\nthat are found from: 
\n\t'different System Block Sizes' and from: 
\n\t'different Data Tranfer Policies. 
\n\nThe Different Block sizes compared here are: 
\n\t'(1 Word Block) vs. (4 Word Block)'. 
\n\nAnd the different I/O Policies compared here are:
\n\t'(NonBurst) vs (Burst)' Data Transfer.
\n\nIn order for me to accomplish this 'Lofty Goal' through this program, 
\n\n\tI DESPERATELY NEED YOUR HELP! 
\nI need for you to 'Please provide the Two Primary Data Factors' that I am missing; 
\nThose factors are:"
oWMissRateReq:	.asciiz	"\nPlease enter a (1-Word Block) Percent Miss Penalty Rate:\t  "
fWMissRateReq:	.asciiz	"\nPlease enter a (4-Word Block) Percent Miss Penalty Rate:\t  "
#-----------------------------------------------------------------------------
oWordMissCalcOut: .asciiz "\n\n
=============================================================================================\n
\t        One Word Block Miss Penalty Calculation Results\n
=============================================================================================\n"
#-----------------------------------------------------------------------------
oWordMissRateOut:	.asciiz	"\nUsing a One-Word Block Percent Miss Penalty Rate of: \t\t\t"
oWordMissCTimeOut:	.asciiz "\nthe (One-Word Block) Miss Penalty Cycle Time is: \t\t\t\t"
oWordMissAveOut:	.asciiz "\nMaking your One-Word Block Miss Penalty Average: \t\t\t\t"
#-----------------------------------------------------------------------------
nbfWordMissCalcOut: .asciiz "\n\n
=============================================================================================\n
\t        Four Word Block (Non-Burst) Miss Penalty Calculation Results\n
=============================================================================================\n"
#-----------------------------------------------------------------------------
nbfWordMissRateOut:	.asciiz	"\nUsing a Four-Word Block (Non-Burst) Percent Miss Penalty Rate of: \t\t"
nbfWordMissCTimeOut:	.asciiz "\nthe Four-Word Block (Non-Burst) Miss Penalty Cycle Time is: \t\t"
nbfWordMissAveOut:	.asciiz "\nMaking your Four-Word Block (Non-Burst) Miss Penalty Average: \t\t"
#-----------------------------------------------------------------------------
bfWordMissCalcOut: .asciiz "\n\n
============================================================================================\n
\t        Four Word Block (Burst) Miss Penalty Calculation Results\n
============================================================================================\n"
#-----------------------------------------------------------------------------
bfWordMissRateOut:	.asciiz	"\nUsing a Four-Word Block (Burst) Percent Miss Penalty Rate of: \t\t"
bfWordMissCTimeOut:	.asciiz "\nthe Four-Word Block (Burst) Miss Penalty Cycle Time is: \t\t\t"
bfWordMissAveOut:	.asciiz "\nMaking your Four-Word Block (Burst) Miss Penalty Average: \t\t\t"
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
cflf:   .asciiz	"\n"
theEnd: .asciiz "\n\n
===========================================================================================\n
\t\t\t<<<<<<< The End >>>>>>>\n
===========================================================================================\n"
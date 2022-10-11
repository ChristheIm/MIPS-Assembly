# Kyungchan Im
# CST - 307
# 09/06/2022
# Hello World Exercise
# In Class Exercise

# Variable declarations
.data
	# The .asciiz assembler directive creates
	# an ASCII string in memory terminated by 
	# the null character. 
	# Not strings are surrounded by double-quotes
	msg: .asciiz "Hello World!\n"


# All program cod is placed after the
# .test assembler directive
.text

# Declare main as a global function
.globl main

# The label ‘main’ represents the starting point
main: 
	# Run the print_string syscall which has code 4
	li	$v0, 4		# load immediate - Code for syscall (puts in your console) : print string
	la	$a0, msg	# load address - Pointer to the string 
	syscall		# print the string
	li	$v0, 10	# Code for syscall: exit
	syscall
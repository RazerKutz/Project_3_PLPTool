.org 0x10000000

# Initializations
li $sp, 0x10fffffc

li $t0, 0xf0000000 # 0(CommandBuffer), 4(statusBuffer), 8(reciveBuffer)
li $t5, 0b0100000 # Bit mask to Cheak Upper.
li $t6, 0b00101110

li $t9, 0b10 # Bit mask for Status Buffer

# Mask creation:
#				li $t1, 0b100
# 				and $t2 (Destenation of Result), $t0 (Data), $t1 (Mask)

# Initialize any registers you will be using here.
# It can be helpful to include a comment about a register's purpose
# next to an initialization at the start of the program for reference.

j main
nop

array_ptr:			# Label pointing to 100 word array
	.space 100


main:
	# NOTE $s1 head, $s0 tail
	li $s0, array_ptr # Base of pointer.
	move $s1, $s0 # memory for where the the start of the pointer is. May not need this.

	# TODO: write your primary program within this loop
	read_UART: # Test loop for UART
		lw $t1, 4($t0)

		# 1. Cheak status buffer to see if there is a Character ready to be
		# recived.
		and $t2, $t1, $t9

		# 2. If there is a Character then retreve it from the revice buffer and
		# store it in the array
		bne $t2, $0 receive_character
		nop

	j main
	nop

	receive_character:
		lw $t3, 8($t0) # $t3 holds the actual Character.
		beq $t3, $t6 found_period
		nop
		and $t2, $t3, $t5 # using masking to see if its upper case letter.
		beq $t2, $0 convert_to_lower # If upper case convert to lower.
		nop
		beq $t3, $t5 clear_status # If Character is a space skip.
		nop
		j write_to_array
		nop

	convert_to_lower:
		addiu $t3, $t3, 32
		j write_to_array
		nop

	write_to_array:
		sw $t3, 0($s0)
		addiu $s0, $s0, 4
		j clear_status
		nop

	clear_status:
		# 3. Then send the command buffer a clear command so the UART sends the next
		# Character.
		sw $t9, 0($t0)
		# 4. Loop
		j read_UART
		nop
	found_period:
		addiu $s0, $s0, -4
		j cheak_palindrome
		nop
	cheak_palindrome:
		lw $t7, 0($s0)
		lw $t8, 0($s1)
		bne $t7, $t8 not_palindrome
		nop
		slt $s7, $s0, $s1
		bne $s7, $0 finished_check
		nop
		addiu $s0, $s0, -4
		addiu $s1, $s1, 4
		j cheak_palindrome

	not_palindrome:
		li $a0, 0
		sw $t9, 0($t0)
		call project3_print
		j main
	finished_check:
		li $a0, 1
		sw $t9, 0($t0)
		call project3_print
		j main

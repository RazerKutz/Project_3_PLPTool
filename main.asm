.org 0x10000000

# Initializations
li $sp, 0x10fffffc

li $t0, 0xf0000000 # 0(CommandBuffer), 4(statusBuffer), 8(reciveBuffer)
li $t5, 0b0100000 # Bit mask to Cheak Upper.

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

	# Psudo Code
	# Main Loop
	# if (statusBuffer == 0b11 ) then //Use bit masking here to check if the bit 2^1 is high.
		# //reciveBuffer has a Character!
		# Store reciveBuffer Character into array. (sw)
		# Send reset 0b10 to commandRagister (sw)

	li $s0, array_ptr # Base of pointer.
	# li $s1, $s0 # memory for where the the start of the pointer is. May not need this.

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
		and $t2, $t3, $t5 # using masking to see if its upper case letter.
		beq $t2, $0 convert_to_lower # If upper case convert to lower.
		nop
		j write_to_array
		nop

	convert_to_lower:
		addiu $t3, $t3, -32
		j write_to_array
		nop

	write_to_array:
		sw $t3, 0($s0)
		j clear_status
		nop

	clear_status:
		# 3. Then send the command buffer a clear command so the UART sends the next
		# Character.
		addiu $s0, $s0, 4
		sw $t9, 0($t0)
		# 4. Loop
		j read_UART
		nop

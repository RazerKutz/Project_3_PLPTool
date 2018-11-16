.org 0x10000000

# Initializations
li $sp, 0x10fffffc


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
	li $s0, array_ptr #Base of pointer.
	# TODO: write your primary program within this loop
	# 1. Cheak status buffer to see if there is a Character ready to be
	# recived.
	# 2. If there is a Character then retreve it from the revice buffer and
	# store it in the array
	# 3. Then send the command buffer a clear command so the UART sends the next
	# Character.
	# 4. Loop

	# Psudo Code
	# Main Loop
	# if (statusBuffer == 0b11 ) then //Use bit masking here to check if the bit 2^1 is high.
		# //reciveBuffer has a Character!
		# Store reciveBuffer Character into array. (sw)
		# Send reset 0b10 to commandRagister (sw)



	j main
	nop

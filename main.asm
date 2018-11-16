.org 0x10000000

# Initializations
li $sp, 0x10fffffc



# Initialize any registers you will be using here.
# It can be helpful to include a comment about a register's purpose
# next to an initialization at the start of the program for reference.

j main
nop

array_ptr:			# Label pointing to 100 word array
	.space 100


main:
	# TODO: write your primary program within this loop
	# 1. Get the cheak status buffer to see if there is a char to recive.
	# 2. If there is a Character then retreve the data in the revice buffer
	# 3. then send the command buffer a clear buffer command.

	# I will also need
	j main
	nop

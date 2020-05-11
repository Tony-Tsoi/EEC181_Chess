module control ( // Avalon Bus interface stuff
);
// should contain a block RAM for the move list/tree
// 1. wait for Avalon bus to feed in current board state
// 2. feeds move(s) into LMG, waits, get moves from LMG fifo and write into block RAM
// 3. for multiple depth: repeat step 2 and write into do/undo stack, until certain depth reached
// 4. wait for SW to retrieve move list/tree from block RAM

// TODO: create block RAM to satisfy the Avalon Bus spec
// TODO: create state machine to wait for done signal from LMG and write into block RAM
// TODO: make hardware that creates a boardstate that makes the move 
	// (in consideration of castling, which is 2 moves in 1)
// TODO: look into burst read from master
// TODO: for multiple depth: 
	// 1. modify state machine to feed the move list back
	// 2. add do/undo stack
	// 3. add tags (ptr, start, end) into block RAM (if applicable)
	
// Proposed king in-check checking methods
	// 1. Utilizing LMG to check - would loop the list back into LMG and let LMG return a valid bit attached to the tag
		// and prune by software
	// 2. Search for an extra depth and let software prune it (since our eval HW doesn't check that)

lmg LMG (.clk(clk), // IOs
);






endmodule
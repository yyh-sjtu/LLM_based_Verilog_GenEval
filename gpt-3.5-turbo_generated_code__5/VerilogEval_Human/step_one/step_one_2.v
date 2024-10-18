module top_module(
	output one
	);

	// always block to drive the output 'one' to logic high
	always @(*)
	begin
		one = 1'b1;
	end

endmodule


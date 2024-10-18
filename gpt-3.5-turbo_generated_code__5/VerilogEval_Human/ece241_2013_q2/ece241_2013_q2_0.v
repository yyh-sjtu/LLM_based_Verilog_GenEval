
module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Output Declarations
	wire out_sop;
	wire out_pos;

	// SOP Form Calculation
	assign out_sop = (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (~a & ~b & c & ~d);

	// POS Form Calculation
	assign out_pos = (a | b | c | ~d) & (a | ~b | c | d) & (~a | b | ~c | d);

endmodule

module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg out;

always @(*) begin
	case(sel)
		0: out = in[0];
		1: out = in[1];
		2: out = in[2];
		// Add cases for all 256 inputs
	endcase
end

endmodule
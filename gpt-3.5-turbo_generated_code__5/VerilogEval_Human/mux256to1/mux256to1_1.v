module top_module (
	input [255:0] in,
	input [7:0] sel,
	output reg out
);

always @(in, sel) begin
	case(sel)
		8'b00000000: out = in[0];
		8'b00000001: out = in[1];
		8'b00000010: out = in[2];
		// Add more cases for selecting bits in[3], in[4], ..., in[255]
		default: out = 1'b0; // Default to 0 if sel value is out of range
	endcase
end

endmodule


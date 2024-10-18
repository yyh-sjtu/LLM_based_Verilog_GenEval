module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare internal wires
	wire [7:0] byte_0;
	wire [7:0] byte_1;
	wire [7:0] byte_2;
	wire [7:0] byte_3;

	// Split the input vector into bytes
	assign byte_0 = in[7:0];
	assign byte_1 = in[15:8];
	assign byte_2 = in[23:16];
	assign byte_3 = in[31:24];

	// Reverse the byte order
	assign out = {byte_3, byte_2, byte_1, byte_0};

endmodule


module shift_register (
	input clk,
	input enable,
	input S,
	output reg [7:0] Q
);

reg [7:0] temp;

always @(posedge clk) begin
	if (enable) begin
		temp <= {temp[6:0], S};
		Q <= temp;
	end
end

endmodule

module multiplexer (
	input [2:0] select,
	input [7:0] input,
	output reg Z
);

always @* begin
	case(select)
		3'b000: Z = input[0];
		3'b001: Z = input[1];
		3'b010: Z = input[2];
		3'b011: Z = input[3];
		3'b100: Z = input[4];
		3'b101: Z = input[5];
		3'b110: Z = input[6];
		3'b111: Z = input[7];
		default: Z = 0;
	endcase
end

endmodule

module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

wire [7:0] Q;

shift_register sr(
	.clk(clk),
	.enable(enable),
	.S(S),
	.Q(Q)
);

multiplexer mux(
	.select({A,B,C}),
	.input(Q),
	.Z(Z)
);

endmodule


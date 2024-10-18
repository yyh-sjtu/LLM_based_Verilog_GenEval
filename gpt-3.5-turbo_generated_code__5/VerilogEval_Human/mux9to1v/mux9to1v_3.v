module top_module (
	input [15:0] a,
	input [15:0] b,
	input [15:0] c,
	input [15:0] d,
	input [15:0] e,
	input [15:0] f,
	input [15:0] g,
	input [15:0] h,
	input [15:0] i,
	input [3:0] sel,
	output logic [15:0] out
);

reg [15:0] temp;

always @(*) begin
	case(sel)
		4'b0000: temp = a;
		4'b0001: temp = b;
		4'b0010: temp = c;
		4'b0011: temp = d;
		4'b0100: temp = e;
		4'b0101: temp = f;
		4'b0110: temp = g;
		4'b0111: temp = h;
		4'b1000: temp = i;
		default: temp = 16'b1111_1111_1111_1111;
	endcase
end

assign out = temp;

endmodule


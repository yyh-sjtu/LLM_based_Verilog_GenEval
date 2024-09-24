module TopModule (
	input [3:0] a,
	input [3:0] b,
	input [3:0] c,
	input [3:0] d,
	input [3:0] e,
	output [3:0] q
);
    always @(a, b, c, d, e)
        case (a)
            3'b000: q <= 4'b0000;
            3'b001: q <= 4'b0001;
            3'b010: q <= 4'b0010;
            3'b011: q <= 4'b0100;
            3'b100: q <= 4'b0101;
            3'b101: q <= 4'b1010;
            3'b110: q <= 4'b110;
            3'b111: q <= 4'b111;
        endcase
endmodule


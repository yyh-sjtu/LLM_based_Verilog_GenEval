module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] sum;
	wire overflow;

	assign s = sum;
	assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]); // overflow occurs when the signs of a, b, and s are not consistent

	always @* begin
		sum = a + b;
	end

endmodule


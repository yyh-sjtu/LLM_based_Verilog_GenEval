module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

// Internal signals
reg [7:0] sum;
reg overflow;

// Combinational logic
assign s = sum;
assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

// Sequential logic
always @(*) begin
	sum = a + b;
end

endmodule


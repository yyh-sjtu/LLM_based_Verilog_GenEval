module full_adder_16bit(
input [15:0] a,
input [15:0] b,
input cin,
output [15:0] sum,
output cout
);

wire [15:0] sum_temp;
wire c;

full_adder fa0(a[0], b[0], cin, sum[0], c);
full_adder fa1(a[1], b[1], c, sum[1], c);
full_adder fa2(a[2], b[2], c, sum[2], c);
full_adder fa3(a[3], b[3], c, sum[3], c);
full_adder fa4(a[4], b[4], c, sum[4], c);
full_adder fa5(a[5], b[5], c, sum[5], c);
full_adder fa6(a[6], b[6], c, sum[6], c);
full_adder fa7(a[7], b[7], c, sum[7], c);
full_adder fa8(a[8], b[8], c, sum[8], c);
full_adder fa9(a[9], b[9], c, sum[9], c);
full_adder fa10(a[10], b[10], c, sum[10], c);
full_adder fa11(a[11], b[11], c, sum[11], c);
full_adder fa12(a[12], b[12], c, sum[12], c);
full_adder fa13(a[13], b[13], c, sum[13], c);
full_adder fa14(a[14], b[14], c, sum[14], c);
full_adder fa15(a[15], b[15], c, sum[15], cout);

endmodule

module
module lfsr( 
input clk,
input reset,
output reg [4:0] q
); 
reg [4:0] r_reg;
wire [4:0] r_next;
wire feedback_value;

always @(posedge clk or posedge reset) begin
if(reset)
r_reg <= 5'b1;
else
r_reg <= r_next;
end

assign r_next[0] = r_reg[4] ^ r_reg[3];
assign r_next[1] = r_reg[0];
assign r_next[2] = r_reg[1];
assign r_next[3] = r_reg[2];
assign r_next[4] = r_reg[3];

assign q = r_reg;

endmodule


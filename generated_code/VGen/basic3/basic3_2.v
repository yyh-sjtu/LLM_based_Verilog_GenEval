module full_adder(
input [15:0] a,
input [15:0] b,
input cin,
output [15:0] sum,
output cout
);

wire [15:0] carry;
wire [15:0] a_xor_b;
wire [15:0] a_and_b;

genvar i;
generate
for(i = 0; i < 16; i=i+1) begin
xor x1(a[i], b[i], a_xor_b[i]);
and a1(a[i], b[i], a_and_b[i]);
end
endgenerate

assign sum[0] = a_xor_b[0] ^ cin;
assign carry[0] = a_and_b[0] | (a_xor_b[0] & cin);

generate
for(i = 1; i < 16; i=i+1) begin
assign sum[i] = a_xor_b[i] ^ carry[i-1];
assign carry[i] = a_and_b[i] | (a_xor_b[i] & carry[i-1]);
end
endgenerate

assign cout = carry[15];

endmodule

module instantiates the full adder and connects the inputs and outputs
module priority_encoder( 
input [2:0] in,
output reg [1:0] pos );

full_adder fa_inst_in1 (
a, {in[2], 13'b0}, 1'b0, sum, cout
);
  
assign pos = sum;

endmodule

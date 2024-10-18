
module adder_8bit (
  input [7:0] a,
  input [7:0] b,
  input cin,
  output reg [7:0] sum,
  output reg cout
);

reg [7:0] c; // Carry output from previous bit

// First bit
full_adder fa0 (a[0], b[0], cin, sum[0], c[0]);

// Intermediate bits
genvar i;
generate
for (i = 1; i < 8; i = i + 1) begin : adder_gen
  full_adder fa (a[i], b[i], c[i-1], sum[i], c[i]);
end
endgenerate

// Last bit
assign cout = c[7];

endmodule
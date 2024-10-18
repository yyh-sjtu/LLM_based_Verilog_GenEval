
module adder_8bit (
  input [7:0] a,
  input [7:0] b,
  input cin,
  output [7:0] sum,
  output cout
);

wire [7:0] carry;
wire [7:0] carry_out;

// First bit-level adder
full_adder adder_0 (
  .a(a[0]),
  .b(b[0]),
  .cin(cin),
  .sum(sum[0]),
  .cout(carry[0])
);

// Intermediate bit-level adders
generate
  genvar i;
  for(i = 1; i < 8; i = i+1) begin : ADDER_GENERATE
    full_adder adder(
      .a(a[i]),
      .b(b[i]),
      .cin(carry[i-1]),
      .sum(sum[i]),
      .cout(carry[i])
    );
  end
endgenerate

// Last bit-level adder
full_adder adder_7 (
  .a(a[7]),
  .b(b[7]),
  .cin(carry[6]),
  .sum(sum[7]),
  .cout(cout)
);

assign carry_out = carry[7];

endmodule


module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
module that implements a 16-bit full adder
// It takes three inputs (a, b, and cin) and produces two outputs (sum and cout)

module full_adder(
  input [15:0] a,
  input [15:0] b,
  input cin,
  output [15:0] sum,
  output cout
);

wire [15:0] carry;
wire [15:0] partial_sum;

genvar i;

generate
  for (i = 0; i < 16; i = i + 1) begin
    and_gate and_gate1(
      .a(a[i]),
      .b(b[i]),
      .out(partial_sum[i])
    );
  end
endgenerate

xor_gate xor_gate1(
  .a(partial_sum),
  .b(carry),
  .out(sum)
);

generate
  for (i = 0; i < 15; i = i + 1) begin
    and_gate and_gate2(
      .a(partial_sum[i]),
      .b(carry[i]),
      .out(carry[i+1])
    );
  end
endgenerate

and_gate and_gate3(
  .a(partial_sum[15]),
  .b(carry[15]),
  .out(cout)
);

endmodule

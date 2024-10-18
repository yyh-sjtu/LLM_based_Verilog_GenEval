
module TopModule(
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] carry;
  wire o_flow;

  // First Full Adder
  FullAdder FA1(
    .a(x[0]),
    .b(y[0]),
    .ci(1'b0),
    .sum(sum[0]),
    .co(carry[0])
  );

  // Remaining Full Adders
  genvar i;
  generate
    for (i = 1; i < 4; i = i + 1) begin: FA_GEN
      FullAdder FA(
        .a(x[i]),
        .b(y[i]),
        .ci(carry[i-1]),
        .sum(sum[i]),
        .co(carry[i])
      );
    end
  endgenerate

  // Overflow Calculation
  assign o_flow = (carry[3] ^ carry[2]);
  assign sum[4] = o_flow;

endmodule


module FullAdder(
  input a,
  input b,
  input ci,
  output sum,
  output co
);

  assign sum = a ^ b ^ ci;
  assign co = (a & b) | (a & ci) | (b & ci);

endmodule
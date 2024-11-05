module adder_8bit(
  input [7:0] a,
  input [7:0] b,
  input cin,
  output [7:0] sum,
  output cout
);
  wire [7:0] carry;
  wire [7:0] carry_out;
  // Generate the carry chain
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin: gen_adders
      full_adder adder(
        .a(a[i]),
        .b(b[i]),
        .cin(carry[i]),
        .sum(sum[i]),
        .cout(carry[i + 1])                                       
      );
    end
  endgenerate
  // Connect the carry-in and carry-out signals
  assign carry[0] = cin;
  assign cout = carry_out[7];
endmodule

module full_adder(
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));
endmodule

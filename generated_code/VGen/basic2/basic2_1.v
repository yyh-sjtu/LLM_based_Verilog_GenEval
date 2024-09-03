module full_adder_16bit(
  input [15:0] a,
  input [15:0] b,
  input cin,
  output [15:0] sum,
  output cout
);

wire [15:0] carry; // Carry out from each full adder

genvar i;
generate
  for(i=0; i<16; i=i+1) begin : gen_adder

    full_adder FA(
      .a(a[i]),
      .b(b[i]),
      .cin(carry[i]),
      .sum(sum[i]),
      .cout(carry[i+1])
    );

  end
endgenerate

assign carry[0] = cin; // Set the carry in for the first adder
assign cout = carry[15]; // Carry out for the 16th adder

endmodule

module full_adder(
  input a,
  input b,
  input cin,
  output sum,
  output cout
);

assign {cout, sum} = a + b + cin;

endmodule


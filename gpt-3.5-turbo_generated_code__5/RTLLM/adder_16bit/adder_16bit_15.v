module adder_16bit (
  input [15:0] a,
  input [15:0] b,
  input Cin,
  output [15:0] y,
  output Co
);

wire [7:0] carry;
wire [7:0] sum;

// 8-bit adder instances
genvar i;
generate
  for (i=0; i<8; i=i+1) begin : adder_instance
    FullAdder adder (
      .a(a[i]),
      .b(b[i]),
      .Ci(i == 0 ? Cin : carry[i-1]),
      .Co(carry[i]),
      .sum(sum[i])
    );
  end
endgenerate

assign y = {sum, sum[7]}; // Concatenate the 8-bit sum with the carry-out to get the 16-bit output
assign Co = carry[7]; // Use the carry-out from the last 8-bit adder as the carry-out for the 16-bit adder

endmodule

module FullAdder (
  input a,
  input b,
  input Ci,
  output Co,
  output sum
);

assign {Co, sum} = a + b + Ci;

endmodule


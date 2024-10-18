
module adder_16bit(
  input [15:0] a,
  input [15:0] b,
  input Cin,
  output [15:0] y,
  output Co
);

// Instantiate 8-bit adders for each bit in the input operands
genvar i;
for (i = 0; i < 16; i = i + 1) begin
  // Create a unique instance name for each 8-bit adder
  wire carry;
  wire sum;
  adder_8bit adder(
    .a(a[i]),
    .b(b[i]),
    .Cin(Cin),
    .y(y[i]),
    .Co(carry)
  );
  assign Cin = carry;
end

// Logic to calculate the Carry-out
assign Co = Cin;

endmodule


module adder_8bit(
  input a,
  input b,
  input Cin,
  output y,
  output Co
);

// Calculate sum of inputs and generate Carry-out
assign {Co, y} = a + b + Cin;

endmodule
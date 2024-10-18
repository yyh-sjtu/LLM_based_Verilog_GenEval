
module TopModule(
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  // Internal wires and registers
  wire [8:0] sum; // A temporary wire to store the sum of a and b with an extra bit

  // Intermediate wire for calculating overflow
  wire carry_out;
  
  // Calculating the sum
  assign sum = a + b;

  // Overflow detection
  assign carry_out = sum[8] ^ sum[7]; // XOR of the MSBs of sum and sum[7]
  
  // Assigning outputs
  assign overflow = carry_out;
  assign s = sum[7:0]; // Extracting the 8 bits of sum to s
  
endmodule
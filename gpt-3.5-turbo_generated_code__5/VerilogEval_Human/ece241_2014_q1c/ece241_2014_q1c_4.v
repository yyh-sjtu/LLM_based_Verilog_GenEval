module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

// Create an intermediate wire to store the sum of a and b
wire [8:0] sum;

// Perform the addition of a and b, storing the result in sum
assign sum = a + b;

// Check if the sum overflows the 8-bit range
assign overflow = (sum[8] == 1);

// Assign the 8-bit sum to the output s
assign s = sum[7:0];

endmodule


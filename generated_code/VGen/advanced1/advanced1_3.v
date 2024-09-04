module signed_adder(input [7:0] a, input [7:0] b, output [7:0] s, output overflow );

  // Internal wire to hold the sum of a and b
  wire [8:0] sum;
  
  // Add the two input numbers a and b
  assign sum = a + b;
  
  // Output the result as the sum
  assign s = sum[7:0];
  
  // Detect overflow by checking the carry out of the 8th bit
  assign overflow = sum[8];
endmodule


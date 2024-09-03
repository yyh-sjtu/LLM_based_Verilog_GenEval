module signed_adder(input [7:0] a, input [7:0] b, output [7:0] s, output overflow );
  
  wire [7:0] sum; // Declare wire for sum of a and b
  wire overflow_detection; // Declare wire for overflow detection
  
  assign {overflow, sum} = a + b; // Adds input a and b and assigns the result to the sum and overflow variables
  
  // Check for overflow by comparing the sign bits of a, b and sum
  assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);
  
  always @(*) begin
    // 2's complement addition
    s = sum; // Assigns the sum value to the output
  end
  
endmodule


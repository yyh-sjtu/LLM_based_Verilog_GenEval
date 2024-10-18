
module TopModule (
  input  wire a,
  input  wire b,
  input  wire cin,
  output wire cout,
  output wire sum
);

  wire carry1, carry2;
  
  // Generate the sum bit
  assign sum = a ^ b ^ cin;
  
  // Generate the carry-out bit
  assign carry1 = a & b;
  assign carry2 = a & cin;
  assign cout = carry1 | carry2;
  
endmodule
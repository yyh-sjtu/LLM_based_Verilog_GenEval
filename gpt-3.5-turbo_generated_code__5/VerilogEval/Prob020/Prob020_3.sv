
module TopModule (
  input  wire [1:0] A,
  input  wire [1:0] B,
  output reg z
);
  
  // Create a temporary wire to store the comparison result
  wire [1:0] cmp_result;
  
  // Compare A[1:0] and B[1:0]
  assign cmp_result = (A == B);
  
  // Set z based on the comparison result
  always @* begin
    if (cmp_result[1] && cmp_result[0]) // Check if both bits of cmp_result are high
      z = 1;
    else
      z = 0;
  end
endmodule
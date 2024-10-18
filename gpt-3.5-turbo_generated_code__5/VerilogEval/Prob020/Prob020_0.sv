
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
  );

  // Create an intermediate wire to store the equality result
  wire is_equal;

  // Compare the two input vectors A and B using the "==" operator
  assign is_equal = (A == B);

  // Assign the output z based on the equality result (1 if A == B, otherwise 0)
  assign z = is_equal ? 1'b1 : 1'b0;

endmodule
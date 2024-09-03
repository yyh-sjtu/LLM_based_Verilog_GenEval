module signed_adder (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

reg [8:0] sum; 
reg sm, bm;
reg carry;

// Find absolute value of a and b
assign sm = a[7];
assign bm = b[7];

always @* begin
  // Pad the values to avoid overflow
  if (sm)
    sum = {1'b1, ~a} + {1'b0, ~b}; 
  else
    sum = {1'b0, a} + {1'b1, b};

  // Check for overflow
  if ((sum[8] != sum[7]) && (sum[8] != carry))
    overflow = 1'b1;
  else
    overflow = 1'b0;

  // Add a and b
  if (sum[8])
    s = {1'b1, ~sum[7:0]};
  else
    s = {1'b0, sum[7:0]};
end

endmodule



module TopModule (
  input [15:0] in,
  output reg [7:0] out_hi,
  output reg [7:0] out_lo
);
  
  // Assigning the lower and upper bytes of the input half-word
  assign out_lo = in[7:0];
  assign out_hi = in[15:8];
  
endmodule
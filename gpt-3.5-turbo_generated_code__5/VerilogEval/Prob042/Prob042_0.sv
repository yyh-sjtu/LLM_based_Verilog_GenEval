
module TopModule (
  input [7:0] in,
  output [31:0] out
);
  
  wire [7:0] sign_bit;
  
  assign sign_bit = {24{in[7]}};
  assign out = {sign_bit, in};
  
endmodule
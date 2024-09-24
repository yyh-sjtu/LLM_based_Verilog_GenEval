
module TopModule (
  input [3:0] in,
  output [3:0] out_both,
  output [3:0] out_any,
  output [3:0] out_different
);

  // Logic for out_both
  assign out_both = {in[3] & in[0], in[0] & in[1], in[1] & in[2], in[2] & in[3]};
  
  // Logic for out_any
  assign out_any = {in[3] | in[0], in[0] | in[1], in[1] | in[2], in[2] | in[3]};
  
  // Logic for out_different
  assign out_different = {in[3] != in[0], in[0] != in[1], in[1] != in[2], in[2] != in[3]};

endmodule
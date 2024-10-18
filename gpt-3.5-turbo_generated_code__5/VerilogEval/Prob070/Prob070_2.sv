
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

assign out_sop = a ^ c;
assign out_pos = ~(b & d);

endmodule
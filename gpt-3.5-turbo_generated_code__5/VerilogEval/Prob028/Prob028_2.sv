
module TopModule(
  input d,
  input ena,
  output q
);

  reg q;

  always@(posedge ena)
    if (ena)
      q <= d;

endmodule
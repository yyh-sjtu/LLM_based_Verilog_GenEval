
module TopModule (
  input  d,
  input  ena,
  output q
);

  reg q;

  always @(posedge ena) begin
    if (ena)
      q <= d;
  end

endmodule
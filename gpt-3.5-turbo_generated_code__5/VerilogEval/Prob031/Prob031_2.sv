
module TopModule(
  input clk,
  input d,
  input q
);

  reg q;

  always @(posedge clk) begin
    q <= d;
  end

endmodule

module TopModule (
  input  wire  clk,
  input  wire  d,
  input  wire  r,
  output wire  q
);
  reg q;

  always @(posedge clk) begin
    if (r)       // Synchronous Reset
      q <= 0;
    else
      q <= d;    // Updating the output based on the input
  end

endmodule
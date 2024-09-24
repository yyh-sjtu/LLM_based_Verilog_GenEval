
module TopModule (
  input clk,
  input ar,
  input d,
  output reg q
);

  always @(posedge clk or negedge ar)
  begin
    if (ar == 0) // Asynchronous reset
      q <= 1'b0;
    else
      q <= d;
  end

endmodule
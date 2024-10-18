
module TopModule (
  input clk,
  input ar,
  input d,
  output reg q
);

  always @(posedge clk or posedge ar)
  begin
    if (ar)
      q <= 0; // Asynchronous reset
    else
      q <= d;
  end

endmodule

module TopModule (
  input  clk,
  input  a,
  output reg [2:0] q
);
  
  reg [2:0] q;

  always @(posedge clk) begin
    if (a) begin
      if (q == 6)
        q <= 0;
      else
        q <= q + 1;
    end
    else
      q <= 4;
  end
  
endmodule
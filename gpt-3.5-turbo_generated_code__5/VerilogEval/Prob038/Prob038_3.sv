
module TopModule(
  input  clk,
  input  reset,
  output [3:0] q
);

  reg [3:0] count;

  always @(posedge clk) begin
    if (reset)
      count <= 0;
    else if (count == 15)
      count <= 0;
    else
      count <= count + 1;
  end

  assign q = count;

endmodule
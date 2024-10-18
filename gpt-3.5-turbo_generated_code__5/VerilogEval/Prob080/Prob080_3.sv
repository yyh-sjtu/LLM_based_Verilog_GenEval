
module TopModule (
  input clk,
  input load,
  input [9:0] data,
  output tc
);

  reg [9:0] counter;
  reg tc_reg;
  reg d_ff;
  always @(posedge clk) begin
    if (load)
      counter <= data;
    else if (counter > 0)
      counter <= counter - 1;
      
    if (counter == 0)
      tc_reg <= 1;
    else
      tc_reg <= 0;
      
    d_ff <= tc_reg;
  end
  
  assign tc = d_ff;

endmodule
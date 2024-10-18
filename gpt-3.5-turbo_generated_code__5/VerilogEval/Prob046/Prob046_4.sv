
module TopModule (
  input  wire clk,
  input  wire reset,
  input  wire [7:0] d,
  output wire [7:0] q
);

  reg [7:0] q_reg;
  
  always @(negedge clk) begin
    if (reset)
      q_reg <= 8'b00110100; // Reset to 0x34
    else
      q_reg <= d;
  end
  
  assign q = q_reg;
  
endmodule
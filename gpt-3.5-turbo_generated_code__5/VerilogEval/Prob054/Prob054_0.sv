
module TopModule (
  input  wire clk,
  input  wire [7:0] in,
  output wire [7:0] pedge
);
  
  reg [7:0] in_prev;

  // Sequential logic to detect the rising edge
  always @(posedge clk) begin
    in_prev <= in;
    pedge <= (in & ~in_prev); // Detect the rising edge
  end

endmodule

module TopModule(
  input  wire clk,
  input  wire reset,
  input  wire [7:0] d,
  output reg [7:0] q
);
  
  always @(posedge clk) begin
    if (reset) begin
      q <= 8'b0; // Reset the output to zero
    end
    else begin
      q <= d; // Assign the input value to the output
    end
  end
  
endmodule
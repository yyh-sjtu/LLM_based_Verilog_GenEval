
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      q <= 4'b0; // Reset shift register to zero
    end
    else begin
      if (load) begin
        q <= data; // Load shift register with data[3:0]
      end
      else if (ena) begin
        q <= {q[2:0], 1'b0}; // Shift right (q[3] becomes zero)
      end
    end
  end
  
endmodule
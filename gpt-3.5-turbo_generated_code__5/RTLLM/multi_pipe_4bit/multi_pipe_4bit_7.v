
module multi_pipe_4bit (
  input clk,
  input rst_n,
  input [3:0] mul_a,
  input [3:0] mul_b,
  output reg [7:0] mul_out
);

  parameter size = 4;
  reg [7:0] partial_products [size-1:0];
  reg [7:0] sum;
  
  assign mul_out = sum;
  
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      // Reset condition
      partial_products <= 8'b0;
      sum <= 8'b0;
    end
    else begin
      // Calculate partial products
      for (integer i = 0; i < size; i = i + 1) begin
        if (mul_b[i]) // If bit is 1
          partial_products[i] <= {mul_a, 4'b0} << i;
        else // If bit is 0
          partial_products[i] <= 8'b0;
      end
      
      // Calculate sum of partial products
      sum <= partial_products[0];
      for (integer i = 1; i < size; i = i + 1) begin
        sum <= sum + partial_products[i];
      end
    end
  end
  
endmodule
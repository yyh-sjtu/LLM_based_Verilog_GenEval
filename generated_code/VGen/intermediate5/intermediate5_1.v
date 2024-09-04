module left_rotate(
  input clk, 
  input reset, 
  input [2:0] amount, 
  input [7:0] data, 
  input load, 
  output reg [7:0] out
);

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      out <= 8'b0; // Reset output to 0 when reset signal is high
    end else begin
      if (load) begin
        out <= data;
      end else begin
        out <= {data[amount-1:0], data[7:amount]}; // Perform left rotation based on amount
      end
    end
  end

endmodule


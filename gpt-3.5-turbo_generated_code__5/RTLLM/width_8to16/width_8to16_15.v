
module width_8to16 (
  input clk,
  input rst_n,
  input valid_in,
  input [7:0] data_in,
  output valid_out,
  output [15:0] data_out
);

  reg [15:0] data_out;          // Output data register
  reg [7:0] data_lock;          // Temporary storage for first arriving data
  reg flag;                     // Flag to indicate the arrival of the second data
  
  always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 16'b0;       // Clear data_out on reset
    end else if (valid_in) begin
      if (flag) begin
        data_out <= {data_lock, data_in};   // Concatenate the data if the second valid data arrives
        flag <= 0;                         // Reset flag
      end else begin
        data_lock <= data_in;              // Store the first valid data
        flag <= 1;                         // Set flag to indicate the arrival of the second data
      end
    end
  end

  always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      valid_out <= 0;         // Clear valid_out on reset
    end else if (valid_in && flag) begin
      valid_out <= 1;         // Set valid_out when both valid inputs are present
    end
  end

endmodule
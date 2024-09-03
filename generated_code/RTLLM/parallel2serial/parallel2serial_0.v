module parallel2serial(
  input clk,   // Clock signal
  input rst_n, // Reset signal
  input [3:0] d, // 4-bit parallel data input
  output reg valid_out, // Valid signal indicating availability of serial output
  output reg dout // Serial output representing the converted data
);

  reg [3:0] data; // Data register to store the parallel input
  reg [1:0] cnt; // Counter to keep track of current parallel input bit

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      cnt <= 2'b0; // Reset counter
      data <= 4'b0; // Reset data register
      valid_out <= 0; // Reset valid signal
    end
    else begin
      if (cnt == 2'b11) begin
        data <= d; // Update data register with parallel input
        cnt <= 2'b0; // Reset counter
        valid_out <= 1; // Set valid signal
      end
      else begin
        data <= {data[2:0], data[3]}; // Shift data register left
        cnt <= cnt + 2'b1; // Increment counter
        valid_out <= 0; // Reset valid signal
      end
    end
  end

  assign dout = data[3]; // Assign most significant bit of data register to serial output

endmodule


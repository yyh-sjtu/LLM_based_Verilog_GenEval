
module parallel2serial (
  input clk,        // Clock signal
  input rst_n,      // Reset signal
  input [3:0] d,    // 4-bit parallel data input
  output valid_out, // Valid signal indicating availability of serial output
  output dout       // Serial output representing converted data
 );

  reg [1:0] cnt;    // Counter register
  reg [3:0] data;   // Data register

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      cnt <= 2'b00; // Reset counter (cnt = 0)
      data <= 4'b0000; // Reset data (all zeros)
    end
    else begin
      if (cnt == 2'b11) begin // Last bit of parallel input
        data <= d; // Update data with parallel input (d)
        cnt <= 2'b00; // Reset counter (cnt = 0)
        valid_out <= 1; // Set valid signal
      end
      else begin
        cnt <= cnt + 1; // Increment counter
        valid_out <= 0; // Clear valid signal
        data <= {data[2:0], d[3]}; // Shift data register
      end
    end
  end

  assign dout = data[3]; // Serial output (MSB of data register)

endmodule
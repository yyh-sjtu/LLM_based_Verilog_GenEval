
module serial2parallel(
  input clk,        // Clock signal
  input rst_n,      // Reset signal (active low)
  input din_serial, // Serial input data
  input din_valid,  // Validity signal for input data
  output reg [7:0] dout_parallel, // Parallel output data (8 bits wide)
  output reg dout_valid          // Validity signal for the output data
);

  reg [3:0] cnt;  // 4-bit counter to keep track of the number of serial input bits received

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin   // Asynchronous active low reset
      cnt <= 4'b0;      // Reset counter
      dout_valid <= 1'b0; // Reset validity signal
      dout_parallel <= 8'b0; // Reset parallel output data
    end
    else begin
      if (din_valid) begin
        if (cnt == 4'b1111) begin
          cnt <= 4'b0;  // Reset counter
          dout_valid <= 1'b1; // Set validity signal
        end
        else begin
          cnt <= cnt + 1;  // Increment counter
          dout_valid <= 1'b0; // Reset validity signal
        end
        dout_parallel <= {din_serial, dout_parallel[7:1]};  // Shift din_serial to the left and update parallel output data
      end
    end
  end

endmodule
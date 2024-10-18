
module serial2parallel (
  input wire clk,
  input wire rst_n,
  input wire din_serial,
  input wire din_valid,
  output reg [7:0] dout_parallel,
  output reg dout_valid
);

  reg [3:0] cnt;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      // Reset the counter and output signals
      cnt <= 0;
      dout_parallel <= 0;
      dout_valid <= 0;
    end
    else begin
      // Increment the counter on each rising edge of the clock
      if (din_valid) begin
        cnt <= cnt + 1;
        // Store the input data in the parallel output register
        dout_parallel[cnt] <= din_serial;
      end
      
      // Check if all bits have been received
      if (cnt == 7) begin
        dout_valid <= 1; // Set the valid output signal
        cnt <= 0; // Reset the counter
      end
      else
        dout_valid <= 0; // Clear the valid output signal
    end
  end

endmodule
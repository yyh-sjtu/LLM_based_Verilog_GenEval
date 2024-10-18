module multi_16bit (
  input clk,             // Chip clock signal
  input rst_n,           // Active-low reset signal
  input start,           // Chip enable signal to initiate multiplication
  input [15:0] ain,      // Multiplicand input
  input [15:0] bin,      // Multiplier input
  output reg [31:0] yout, // Product output
  output reg done        // Completion flag
);

  reg [4:0] i;           // Shift count register
  reg [31:0] areg, breg, yout_r; // Multiplicand, multiplier, product registers
  reg done_r;            // Temporary completion flag

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      i <= 0;           // Reset shift count register
      done_r <= 0;      // Reset temporary completion flag
      areg <= 0;        // Reset multiplicand register
      breg <= 0;        // Reset multiplier register
      yout_r <= 0;      // Reset product register
    end
    else begin
      if (start) begin
        if (i < 17)    // Increment shift count register
          i <= i + 1;
        else
          i <= 0;     // Reset shift count register
      end
      else
        i <= 0;       // Reset shift count register

      if (i == 16)     // Set temporary completion flag
        done_r <= 1;
      else if (i == 17)
        done_r <= 0;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      areg <= 0;      // Reset multiplicand register
      breg <= 0;      // Reset multiplier register
      yout_r <= 0;    // Reset product register
    end
    else begin
      if (start) begin
        if (i == 0) begin
          areg <= ain;  // Store multiplicand
          breg <= bin;  // Store multiplier
        end
        else if (i > 0 && i < 17) begin
          if (areg[i-1]) // Shift and accumulate operation
            yout_r <= yout_r + (breg << (i-1));
        end
      end
    end
  end

  assign yout = yout_r; // Assign product output

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
      done <= 0;        // Reset completion flag
    else
      done <= done_r;   // Assign temporary completion flag to completion flag

  end

endmodule


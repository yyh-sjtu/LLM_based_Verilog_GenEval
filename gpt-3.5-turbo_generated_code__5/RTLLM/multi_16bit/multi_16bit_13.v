module multi_16bit (
  input clk,             // Chip clock signal
  input rst_n,           // Reset signal, active-low
  input start,           // Start signal to initiate the multiplication operation
  input [15:0] ain,      // Multiplicand (a) input signal
  input [15:0] bin,      // Multiplier (b) input signal
  output reg [31:0] yout, // Product output signal
  output reg done         // Completion flag signal
);

  reg [4:0] i;          // Shift count register
  reg [15:0] areg;      // Multiplicand register
  reg [15:0] breg;      // Multiplier register
  reg [31:0] yout_r;    // Product register
  reg done_r;           // Internal multiplication completion flag

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      i <= 0;
      areg <= 0;
      breg <= 0;
      yout_r <= 0;
      done_r <= 0;
    end else begin
      if (start && i < 17) begin
        i <= i + 1;
      end else if (!start) begin
        i <= 0;
      end
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      done_r <= 0;
    end else begin
      if (i == 16) begin
        done_r <= 1;
      end else if (i == 17) begin
        done_r <= 0;
      end
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      yout_r <= 0;
    end else begin
      if (start) begin
        if (i == 0) begin
          areg <= ain;
          breg <= bin;
        end else if (i > 0 && i < 17) begin
          if (areg[i-1] == 1'b1) begin
            yout_r <= yout_r + (breg << (i-1));
          end
        end
      end
    end
  end

  assign yout = yout_r;
  assign done = done_r;
  
endmodule


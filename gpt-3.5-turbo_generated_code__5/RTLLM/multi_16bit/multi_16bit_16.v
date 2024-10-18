
module multi_16bit(
  input clk,
  input rst_n,
  input start,
  input [15:0] ain,
  input [15:0] bin,
  output reg [31:0] yout,
  output reg done
);

  reg [3:0] i;  // Shift count register
  reg [15:0] areg, breg;  // Multiplicand and Multiplier registers
  reg [31:0] yout_r;  // Product register
  reg done_r;  // Multiplication completion flag

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      i <= 4'b0;
      areg <= 16'b0;
      breg <= 16'b0;
      yout_r <= 32'b0;
    end else begin
      if (start && (i < 4'b10000)) begin
        i <= i + 1;
      end else if (!start) begin
        i <= 4'b0;
      end
    end
  end

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      done_r <= 1'b0;
    end else begin
      if (i == 4'b10000) begin
        done_r <= 1'b1;
      end else if (i == 4'b10001) begin
        done_r <= 1'b0;
      end
    end
  end

  always @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      yout <= 32'b0;
    end else begin
      if (start) begin
        // Assign multiplicand and multiplier values
        if (i == 4'b0) begin
          areg <= ain;
          breg <= bin;
        end
        
        // Shift and accumulate operation
        if ((i > 4'b0) && (i < 4'b10001)) begin
          if (areg[i-1]) begin
            yout_r <= yout_r + (breg << (i-1));
          end
        end
      end
      
      // Assign product output
      yout <= yout_r;
    end
  end

  assign done = done_r;

endmodule
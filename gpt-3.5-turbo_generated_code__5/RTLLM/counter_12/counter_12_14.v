module counter_12 (
  input  wire        rst_n,           // Reset signal (active low)
  input  wire        clk,             // Clock signal
  input  wire        valid_count,     // Signal to enable counting
  output reg  [3:0]  out              // 4-bit output representing the current count value
);

  always @ (posedge clk or negedge rst_n)
  begin
    if (!rst_n) begin
      out <= 4'b0000;
    end
    else begin
      if (valid_count) begin
        if (out == 4'd11) begin
          out <= 4'b0000;
        end
        else begin
          out <= out + 1;
        end
      end
    end
  end

endmodule


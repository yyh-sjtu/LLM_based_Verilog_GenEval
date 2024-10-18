
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);

  // Define internal signals
  reg [3:0] next_q;

  // Sequential logic
  always @(posedge clk) begin
    if (reset) begin
      next_q <= 0;
    end else begin
      next_q <= q + 1;
    end
  end

  // Output assignment
  always @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end else begin
      q <= next_q;
    end
  end

endmodule
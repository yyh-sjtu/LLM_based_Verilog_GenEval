
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output reg [1:0] state
);

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b01; // Reset to weakly not-taken
    end else if (train_valid) begin
      if (train_taken && (state != 2'b11)) begin // Increment counter, saturate at 3
        state <= state + 1;
      end else if (!train_taken && (state != 2'b00)) begin // Decrement counter, saturate at 0
        state <= state - 1;
      end
    end
  end

endmodule
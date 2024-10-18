
module signal_generator (
  input clk,
  input rst_n,
  output reg [4:0] wave
);

  reg [1:0] state; // State register

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      state <= 0; // Reset state to 0
      wave <= 0; // Reset wave to 0
    end
    else begin
      case (state)
        0: begin
          wave <= wave + 1; // Increment wave by 1
          if (wave == 4'd31) // Check if wave reaches 31
            state <= 1; // Transition to state 1
        end
        1: begin
          wave <= wave - 1; // Decrement wave by 1
          if (wave == 4'd0) // Check if wave reaches 0
            state <= 0; // Transition to state 0
        end
      endcase
    end
  end

endmodule
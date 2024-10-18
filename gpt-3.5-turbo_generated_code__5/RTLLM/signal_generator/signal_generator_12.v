
module signal_generator (
  input clk,    // Clock signal
  input rst_n,  // Reset signal (active low)
  output reg [4:0] wave  // Output waveform signal
);
  
  reg [1:0] state;  // State register for waveform generation
  
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      // Reset condition
      state <= 0;
      wave <= 0;
    end else begin
      // Waveform generation
      case (state)
        0: begin
          // Increment waveform
          if (wave == 31)
            state <= 1;
          else
            wave <= wave + 1;
        end
        1: begin
          // Decrement waveform
          if (wave == 0)
            state <= 0;
          else
            wave <= wave - 1;
        end
      endcase
    end
  end

endmodule
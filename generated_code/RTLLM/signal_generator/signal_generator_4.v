
module signal_generator (
    input clk,       // Clock signal
    input rst_n,     // Reset signal (active low)
    output reg [4:0] wave // 5-bit output triangular waveform
);

// State register
reg [1:0] state;

// Always block for state and waveform generation
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= 2'b0; // Reset state to 0
        wave <= 5'b0;  // Reset waveform to 0
    end else begin
        // State machine for waveform generation
        case (state)
            2'b00: begin // Increment waveform
                if (wave == 5'b11111) // If waveform reaches 31
                    state <= 2'b01; // Transition to state 1
                else
                    wave <= wave + 1; // Increment waveform by 1
            end
            2'b01: begin // Decrement waveform
                if (wave == 5'b0) // If waveform reaches 0
                    state <= 2'b00; // Transition to state 0
                else
                    wave <= wave - 1; // Decrement waveform by 1
            end
        endcase
    end
end

endmodule
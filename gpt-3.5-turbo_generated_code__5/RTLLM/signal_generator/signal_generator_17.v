
module signal_generator (
    input clk,     // Clock signal used for synchronous operation
    input rst_n,   // Active-low reset signal, 0 for reset and 1 for reset signal inactive
    output reg [4:0] wave // 5-bit output waveform signal representing the generated waveform
);

reg [1:0] state;  // Register used to control the state of the waveform generation

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= 2'b00;  // Clear state to 0 on reset
        wave <= 5'b00000;  // Clear wave to 0 on reset
    end
    else begin
        case (state)
            2'b00: begin
                if (wave == 5'b11111)
                    state <= 2'b01;  // Transition to state 1 when waveform reaches 31
                else
                    wave <= wave + 1; // Increment waveform by 1
            end
            2'b01: begin
                if (wave == 5'b00000)
                    state <= 2'b00;  // Transition back to state 0 when waveform reaches 0
                else
                    wave <= wave - 1; // Decrement waveform by 1
            end
            default: state <= 2'b00; // Default state is 0
        endcase
    end
end

endmodule

module signal_generator (
    input wire clk,    // Clock signal
    input wire rst_n,  // Reset signal (active-low)
    output reg [4:0] wave  // Output waveform signal
);

reg [1:0] state;  // State register for waveform generation

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= 2'b00;  // Clear state on reset
        wave <= 5'b00000; // Clear waveform on reset
    end
    else begin
        case (state)
            2'b00: begin // Increment waveform state
                wave <= (wave == 5'b11111) ? 5'b11111 : wave + 1;
                state <= (wave == 5'b11111) ? 2'b01 : state;
            end
            2'b01: begin // Decrement waveform state
                wave <= (wave == 5'b00000) ? 5'b00000 : wave - 1;
                state <= (wave == 5'b00000) ? 2'b00 : state;
            end
            default: state <= 2'b00;
        endcase
    end
end

endmodule
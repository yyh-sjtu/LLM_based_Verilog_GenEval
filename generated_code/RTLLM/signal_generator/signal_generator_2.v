
module signal_generator (
    input clk,    // Clock signal
    input rst_n,  // Active-low reset signal
    output reg [4:0] wave // 5-bit output waveform signal
);

reg [1:0] state; // State register

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin // Reset state
        state <= 2'b00;
        wave <= 5'b00000;
    end else begin // State transitions
        case (state)
            2'b00: begin // Increment waveform
                if (wave == 5'b11111) 
                    state <= 2'b01;
                else 
                    wave <= wave + 1;
            end
            2'b01: begin // Decrement waveform
                if (wave == 5'b00000) 
                    state <= 2'b00;
                else 
                    wave <= wave - 1;
            end
        endcase
    end
end

endmodule
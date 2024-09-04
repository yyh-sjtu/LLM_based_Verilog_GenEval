
module TopModule (
    input    clk,
    input    reset,
    input    [7:0] in,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE       = 2'b00,  // Waiting for the first byte
        BYTE1      = 2'b01,  // First byte received
        BYTE2      = 2'b10,  // Second byte received
        BYTE3      = 2'b11   // Third byte received
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and done signal generation
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;  // Transition to BYTE1 if the first byte is detected
                end
            end
            
            BYTE1: begin
                next_state = BYTE2;   // Move to BYTE2 after receiving the first byte
            end
            
            BYTE2: begin
                next_state = BYTE3;   // Move to BYTE3 after receiving the second byte
            end
            
            BYTE3: begin
                done = 1'b1;          // Signal done after receiving the third byte
                next_state = IDLE;    // Reset state back to IDLE
            end
            
            default: 
                next_state = IDLE;    // Safety condition for default case
        endcase
    end

endmodule
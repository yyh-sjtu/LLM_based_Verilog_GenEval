
module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE,       // Waiting for start of message
        FIRST_BYTE, // First byte received
        SECOND_BYTE // Second byte received
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0; // Reset done signal
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        // Default next_state and done output
        next_state = current_state;
        done = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin // Check for start of message
                    next_state = FIRST_BYTE;
                end
            end
            
            FIRST_BYTE: begin
                next_state = SECOND_BYTE; // Move to next state after receiving first byte
            end
            
            SECOND_BYTE: begin
                done = 1'b1; // Signal that the third byte is received (done on the next clock cycle)
                next_state = IDLE; // Return to IDLE to wait for the next message
            end
        endcase
    end
endmodule
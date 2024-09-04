
module TopModule (
    input  wire clk,          // Clock input
    input  wire reset,        // Active high synchronous reset
    input  wire [7:0] in,     // 8-bit input
    output reg done           // Done output signal
);

// State definitions for the FSM
typedef enum reg [1:0] {
    IDLE,      // Wait for the first byte indicating the start of a message
    BYTE1,     // First byte of the message received
    BYTE2,     // Second byte of the message received
    BYTE3      // Third byte of the message received
} state_t;

state_t current_state, next_state;

// Sequential logic for state transition and done signal generation
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE; // Reset to IDLE state
        done <= 0;             // Reset done signal
    end else begin
        current_state <= next_state; // Transition to the next state
        if (next_state == BYTE3) begin
            done <= 1; // Set done signal when third byte is received
        end else begin
            done <= 0; // Clear done signal in other cases
        end
    end
end

// Combinatorial logic for determining next state
always @(*) begin
    case (current_state)
        IDLE: begin
            if (in[3] == 1'b1) begin
                next_state = BYTE1; // Start of a new message
            end else begin
                next_state = IDLE; // Stay in IDLE
            end
        end
        BYTE1: begin
            next_state = BYTE2; // Move to second byte
        end
        BYTE2: begin
            next_state = BYTE3; // Move to third byte
        end
        BYTE3: begin
            next_state = IDLE; // After receiving third byte, return to IDLE
        end
        default: next_state = IDLE; // Default case, should not reach here
    endcase
end

endmodule
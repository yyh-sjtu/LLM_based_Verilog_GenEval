
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

// State encoding
typedef enum reg [1:0] {
    B = 2'b00, // State B
    A = 2'b01  // State A
} state_t;

// State register
state_t current_state, next_state;

// Synchronous state transition
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= B; // Reset to state B
    end else begin
        current_state <= next_state; // Transition to the next state
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        B: begin
            if (in == 0) begin
                next_state = A; // B --in=0--> A
                out = 1; // Output 1 in state B
            end else begin
                next_state = B; // B --in=1--> B
                out = 1; // Output 1 in state B
            end
        end
        A: begin
            if (in == 0) begin
                next_state = B; // A --in=0--> B
                out = 0; // Output 0 in state A
            end else begin
                next_state = A; // A --in=1--> A
                out = 0; // Output 0 in state A
            end
        end
        default: begin
            next_state = B; // Fallback to state B if undefined state
            out = 1; // Default output in state B
        end
    endcase
end

endmodule
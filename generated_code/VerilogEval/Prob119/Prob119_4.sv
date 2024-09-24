
module TopModule (
    input clk,
    input areset,
    input in,
    output reg out
);

// State encoding
typedef enum reg [1:0] {
    A = 2'b00,
    B = 2'b01,
    C = 2'b10,
    D = 2'b11
} state_t;

// State variable
state_t current_state, next_state;

// Sequential logic: State transition
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= A;  // Reset to state A
    end else begin
        current_state <= next_state;  // Transition to next state
    end
end

// Combinational logic: Next state and output logic
always @(*) begin
    // Default outputs and next state
    out = 0; // Default output
    next_state = current_state; // Default to current state

    case (current_state)
        A: begin
            if (in) begin
                next_state = B;  // Transition to state B
            end else begin
                next_state = A;  // Stay in state A
            end
            out = 0; // Output remains 0
        end

        B: begin
            if (in) begin
                next_state = B;  // Stay in state B
            end else begin
                next_state = C;  // Transition to state C
            end
            out = 0; // Output remains 0
        end

        C: begin
            if (in) begin
                next_state = D;  // Transition to state D
            end else begin
                next_state = A;  // Transition to state A
            end
            out = 0; // Output remains 0
        end

        D: begin
            if (in) begin
                next_state = B;  // Transition to state B
            end else begin
                next_state = C;  // Transition to state C
            end
            out = 1; // Output is 1
        end

        default: begin
            next_state = A; // Default to state A on any unexpected state
            out = 0; // Default output
        end
    endcase
end

endmodule
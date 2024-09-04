
module TopModule (
    input  clk,
    input  reset,
    input  in,
    output reg out
);

// State encoding
typedef enum logic [1:0] {
    A = 2'b00,
    B = 2'b01,
    C = 2'b10,
    D = 2'b11
} state_t;

// Internal state register
state_t current_state, next_state;

// Sequential logic
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A; // Reset to state A
        out <= 0;           // Output is 0 in state A
    end else begin
        current_state <= next_state; // Update current state to next state
    end
end

// Combinational logic to determine next state and output
always_comb begin
    next_state = current_state; // Default to hold the current state
    out = 0; // Default output

    case (current_state)
        A: begin
            if (in) 
                next_state = B; // Transition A to B on in=1
        end
        B: begin
            if (in) 
                next_state = B; // Stay in B on in=1
            else 
                next_state = C; // Transition B to C on in=0
        end
        C: begin
            if (in) 
                next_state = D; // Transition C to D on in=1
            else 
                next_state = A; // Transition C to A on in=0
        end
        D: begin
            if (in) 
                next_state = B; // Transition D to B on in=1
            else 
                next_state = C; // Transition D to C on in=0
            out = 1; // Set output to 1 when in state D
        end
        default: begin
            next_state = A; // Default to state A
        end
    endcase
end

endmodule
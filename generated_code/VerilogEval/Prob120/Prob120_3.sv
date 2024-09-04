
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State Transition Logic
    always @(*) begin
        // Default next state and output
        next_state = current_state;
        out = 1'b0; // Default output value

        case (current_state)
            A: begin
                if (in) next_state = B;
                // Output is already set to 0
            end
            B: begin
                if (in) next_state = B; // stays in B
                else next_state = C;
                // Output is already set to 0
            end
            C: begin
                if (in) next_state = D;
                else next_state = A;
                // Output is already set to 0
            end
            D: begin
                if (in) next_state = B;
                else next_state = C;
                out = 1'b1; // Output is 1 in state D
            end
            default: next_state = A; // Fallback to state A for safety
        endcase
    end

    // Output Logic and State Update Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A; // Reset to State A
            out <= 1'b0;        // Output should also be reset
        end else begin
            current_state <= next_state; // Update current state
        end
    end

endmodule
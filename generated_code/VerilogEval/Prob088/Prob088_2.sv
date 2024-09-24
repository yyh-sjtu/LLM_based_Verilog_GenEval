
module TopModule (
    input       clk,
    input       areset,
    input       x,
    output reg  z
);

    // State encoding using one-hot encoding
    typedef enum reg [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default values
        next_state = current_state;
        z = 1'b0;

        case (current_state)
            A: begin
                if (x) begin
                    next_state = B; // Transition to B
                    z = 1'b1;       // Output z = 1
                end // if x == 0, z remains 0 and stay in state A
            end

            B: begin
                if (x) begin
                    z = 1'b0; // Output z = 0
                end else begin
                    // x is 0, remain in B
                    z = 1'b1; // Output z = 1
                end
            end

            default: begin
                next_state = A; // Default to state A for safety
            end
        endcase
    end

endmodule
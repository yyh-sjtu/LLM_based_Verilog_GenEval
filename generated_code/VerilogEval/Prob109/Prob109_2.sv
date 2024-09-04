
module TopModule (
    input wire clk,
    input wire areset,
    input wire in,
    output reg out
);

    // Define state encoding
    typedef enum reg [1:0] {
        A = 2'b00,  // State A
        B = 2'b01   // State B
    } state_t;

    // State variables
    state_t current_state, next_state;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B; // Reset to state B
            out <= 1'b1;        // Output for state B
        end else begin
            current_state <= next_state; // Update current state
            out <= (next_state == A) ? 1'b0 : 1'b1; // Update output based on next state
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (in == 0) begin
                    next_state = B; // A --0--> B
                end else begin
                    next_state = A; // A --1--> A
                end
            end
            B: begin
                if (in == 0) begin
                    next_state = A; // B --0--> A
                end else begin
                    next_state = B; // B --1--> B
                end
            end
            default: begin
                next_state = B; // Default to state B
            end
        endcase
    end

endmodule
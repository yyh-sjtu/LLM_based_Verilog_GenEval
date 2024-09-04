
module TopModule (
    input clk,
    input areset, // Asynchronous reset
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

    // Current state and next state variables
    state_t current_state, next_state;

    // Sequential logic: state transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state; // Update current state
        end
    end

    // Combinational logic: next state and output logic
    always @(*) begin
        // Default assignments for next state and output
        out = 0; // Default output (Moore state machine behavior)
        next_state = current_state; // Default next state (stay in current state)
        
        case (current_state)
            A: begin
                if (in) begin
                    next_state = B; // from A to B if in = 1
                end
            end
            B: begin
                if (in) begin
                    next_state = B; // remains in B if in = 1
                end else begin
                    next_state = C; // from B to C if in = 0
                end
            end
            C: begin
                if (in) begin
                    next_state = D; // from C to D if in = 1
                end else begin
                    next_state = A; // from C to A if in = 0
                end
            end
            D: begin
                if (in) begin
                    next_state = B; // from D to B if in = 1
                end else begin
                    next_state = C; // from D to C if in = 0
                end
                out = 1; // output = 1 when in state D
            end
        endcase
    end

endmodule
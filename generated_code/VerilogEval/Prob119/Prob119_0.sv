
module TopModule (
    input  wire clk,
    input  wire areset,
    input  wire in,
    output reg  out
);

    // Define state encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset and state update on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A; // Asynchronous reset to state A
            out <= 1'b0;        // Ensure output is reset to 0
        end else begin
            current_state <= next_state; // Update current state
            case (next_state)
                A, B, C: out <= 1'b0; // Output is 0 in states A, B, and C
                D: out <= 1'b1;      // Output is 1 in state D
            endcase
        end
    end

    // Next state logic based on current state and input
    always @(*) begin
        case (current_state)
            A: next_state = (in) ? B : A; // Stay in A if in=0, go to B if in=1
            B: next_state = (in) ? B : C; // Stay in B if in=1, go to C if in=0
            C: next_state = (in) ? D : A; // Go to D if in=1, go back to A if in=0
            D: next_state = (in) ? B : C; // Go to B if in=1, go to C if in=0
            default: next_state = A;      // Default case (shouldn't happen)
        endcase
    end

endmodule

module TopModule (
    input  wire clk,
    input  wire reset,
    input  wire s,
    input  wire w,
    output reg  z
);

    // State Encoding
    typedef enum logic {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // Counter for the number of '1's received
    reg [2:0] count; // 3-bit counter (0 to 3)

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A; // Reset to state A
            count <= 3'b000;   // Reset the counter
            z <= 0;            // Reset output z
        end else begin
            state <= next_state; // Move to the next state
        end
    end

    always_ff @(posedge clk) begin
        if (state == STATE_B) begin
            if (count < 3) begin
                count <= count + 1; // Increment the counter until it reaches 3
            end else begin
                // After three cycles, evaluate the count
                if (count == 3'b010) begin
                    z <= 1; // Two ones were detected
                end else begin
                    z <= 0; // Not two ones
                end
                count <= 3'b000; // Reset the counter for the next sequence
            end
        end else begin
            z <= 0; // In state A, output z is always 0
        end
    end

    // FSM state transition
    always_comb begin
        case (state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B; // Transition to B on s = 1
                    count = 0; // Initialize count when entering state B
                end else begin
                    next_state = STATE_A; // Remain in state A
                end
            end
            STATE_B: begin
                if (count < 3) begin
                    next_state = STATE_B; // Stay in B until we've sampled three times
                end else begin
                    next_state = STATE_B; // Remain in B for the next evaluation
                end
            end
            default: next_state = STATE_A; // Default state if unknown
        endcase
    end

    // Count logic
    always_ff @(posedge clk) begin
        if (state == STATE_B) begin
            if(count < 3) begin
                if (w) begin
                    count <= count + 1; // Increment count if w is 1
                end
            end
        end
    end

endmodule
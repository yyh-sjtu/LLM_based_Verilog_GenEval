
module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State Encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    // State and Next State Variables
    state_t current_state, next_state;

    // Counter to keep track of the number of '1's seen in w
    reg [1:0] count_w;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            count_w <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // FSM Next State Logic
    always @* begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                    count_w = 2'b00; // Reset count on state transition
                    z = 1'b0;
                end else begin
                    next_state = A;
                    z = 1'b0;
                end
            end
            B: begin
                // Shift count and check w
                if (count_w < 2'b11) begin
                    count_w = count_w + (w ? 1'b1 : 1'b0);
                    next_state = B;
                    z = 1'b0;
                end else begin
                    if (count_w == 2'b10) begin
                        z = 1'b1; // Set z if we've seen '1's exactly 2 times
                    end else begin
                        z = 1'b0; // Otherwise reset z
                    end
                    next_state = B; // Stay in state B
                end
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end
endmodule
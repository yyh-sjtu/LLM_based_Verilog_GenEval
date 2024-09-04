
module TopModule (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum reg [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S0; // Reset to state 000
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default assignments
        next_state = current_state; // Stay in current state
        z = 1'b0; // Default output

        case (current_state)
            S0: begin
                next_state = (x) ? S1 : S0; // Stay in S0 or go to S1
                z = 1'b0;
            end
            
            S1: begin
                next_state = (x) ? S4 : S1; // Stay in S1 or go to S4
                z = 1'b0;
            end
            
            S2: begin
                next_state = (x) ? S1 : S2; // Stay in S2 or go to S1
                z = 1'b0;
            end
            
            S3: begin
                next_state = (x) ? S2 : S1; // Go to S2 or stay in S1
                z = 1'b1;
            end
            
            S4: begin
                next_state = (x) ? S4 : S3; // Stay in S4 or go to S3
                z = 1'b1;
            end
            
            default: begin
                next_state = S0; // Default to state S0
                z = 1'b0;
            end
        endcase
    end

endmodule
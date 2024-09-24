
module TopModule (
    input  clk,
    input  reset,
    input  in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum reg [3:0] {
        S0 = 4'b0000,  // Initial state
        S1 = 4'b0001,  // Received 0
        S2 = 4'b0010,  // Received 01
        S3 = 4'b0011,  // Received 011
        S4 = 4'b0100,  // Received 0111
        S5 = 4'b0101,  // Received 01111
        S6 = 4'b0110,  // Received 011111
        S7 = 4'b0111,  // Received 0111111 -> Error state
        S8 = 4'b1000   // Received 01111110 -> Flag state
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        // Default output values
        disc = 0;
        flag = 0;
        err = 0;
        
        // Next state logic
        case (current_state)
            S0: begin
                if (in == 0) begin
                    next_state = S0; // remain in S0
                end else begin
                    next_state = S1; // move to S1
                end
            end
            S1: begin
                if (in == 1) begin
                    next_state = S2; // move to S2
                end else begin
                    next_state = S0; // move back to S0
                end
            end
            S2: begin
                if (in == 1) begin
                    next_state = S3; // move to S3
                end else begin
                    next_state = S0; // move back to S0
                end
            end
            S3: begin
                if (in == 1) begin
                    next_state = S4; // move to S4
                end else begin
                    next_state = S0; // move back to S0
                end
            end
            S4: begin
                if (in == 1) begin
                    next_state = S5; // move to S5
                end else begin
                    next_state = S0; // move back to S0
                end
            end
            S5: begin
                if (in == 1) begin
                    next_state = S6; // move to S6
                end else begin
                    next_state = S0; // move back to S0
                end
            end
            S6: begin
                if (in == 0) begin
                    next_state = S8; // Found frame flag
                end else begin
                    next_state = S7; // 7 or more ones, go to error
                end
            end
            S7: begin
                // Remain in error state
                err = 1;  // Signal error
                next_state = S7; // stay in error state
            end
            S8: begin
                // Reset after reading a flag
                flag = 1; // Signal that a flag has been detected
                next_state = S0; // Go back to S0
            end
            default: begin
                next_state = S0; // Default to S0
            end
        endcase
        
        // Discard action
        if (current_state == S6) begin
            disc = 1;  // Signal discard
        end
    end

    // State register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0; // Reset to initial state
        end else begin
            current_state <= next_state; // Transition to the next state
        end
    end
endmodule
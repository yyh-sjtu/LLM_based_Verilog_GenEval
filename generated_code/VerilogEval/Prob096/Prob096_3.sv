
module TopModule (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State definitions for the FSM
    typedef enum reg [2:0] {
        S0,  // Initial state
        S1,  // Received '1'
        S2,  // Received '11'
        S3,  // Received '110'
        S4   // Received '1101'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: begin
                next_state = (data) ? S1 : S0;
            end
            S1: begin
                next_state = (data) ? S2 : S0;
            end
            S2: begin
                next_state = (data) ? S2 : S3;
            end
            S3: begin
                next_state = (data) ? S4 : S0;
            end
            S4: begin
                next_state = S4; // Remain in S4 when the sequence is found
            end
            default: next_state = S0; // Default state
        endcase
    end

    // State update on clock edge, and reset handling
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 0; // Reset start_shifting to 0
        end else begin
            current_state <= next_state;
            start_shifting <= (current_state == S4) ? 1 : start_shifting; // Set to 1 when in S4
        end
    end

    // Reset start_shifting when the FSM is reset
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end 
    end

endmodule

module adv_fsm(
    input clk,
    input reset,
    input x,
    output reg z
);
    // State encoding
    reg [1:0] present_state, next_state;
    parameter IDLE = 2'b00, S1 = 2'b01, S10 = 2'b10, S101 = 2'b11;

    // Sequential block for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) 
            present_state <= IDLE; // Reset state
        else 
            present_state <= next_state; // Update to next state
    end

    // Combinational block for next state logic
    always @(*) begin
        case (present_state)
            IDLE: begin
                if (x) 
                    next_state = S1;  // Move to state S1 if x is 1
                else 
                    next_state = IDLE; // Stay in IDLE
            end
            
            S1: begin
                if (~x) 
                    next_state = S10; // Move to state S10 if x is 0
                else 
                    next_state = IDLE; // Go back to IDLE if x is 1
            end
            
            S10: begin
                if (x) 
                    next_state = S101; // Move to state S101 if x is 1
                else 
                    next_state = IDLE; // Go back to IDLE if x is 0
            end
            
            S101: begin
                next_state = IDLE; // Always go back to IDLE from S101
            end
            
            default: next_state = IDLE; // Default case (should not occur)
        endcase
    end

    // Output logic
    always @(*) begin
        if (present_state == S101)
            z = 1; // Assert z when in state S101
        else
            z = 0; // Deassert z otherwise
    end
endmodule
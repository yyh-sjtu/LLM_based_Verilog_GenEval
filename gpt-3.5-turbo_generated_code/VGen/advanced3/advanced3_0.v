
module adv_fsm(
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [1:0] present_state, next_state;

    // State encoding
    parameter IDLE = 2'b00,
              S1   = 2'b01,
              S10  = 2'b10,
              S101 = 2'b11;

    // State transition logic - combinatorial
    always @(*) begin
        case (present_state)
            IDLE: begin
                if (x)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (~x) // x is 0
                    next_state = S10;
                else
                    next_state = IDLE;
            end
            S10: begin
                if (x)
                    next_state = S101;
                else
                    next_state = IDLE;
            end
            S101: begin
                next_state = IDLE; // After recognizing "101", go back to IDLE
            end
            default: next_state = IDLE; // Default to IDLE in case of any invalid state
        endcase
    end

    // State register - sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= IDLE;
            z <= 0; // z is low during reset
        end
        else begin
            present_state <= next_state;
            if (present_state == S101) 
                z <= 1; // Assert z when current state is S101
            else 
                z <= 0; // Deassert z in other states
        end
    end

endmodule
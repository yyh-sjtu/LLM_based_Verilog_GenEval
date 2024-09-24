
module TopModule (
    input clk,
    input reset,
    input [2:0] s,
    output fr2,
    output fr1,
    output fr0,
    output dfr
);

    // Define state encoding
    parameter ABOVE_S2 = 2'b00;
    parameter BETWEEN_S2_S1 = 2'b01;
    parameter BETWEEN_S1_S0 = 2'b10;
    parameter BELOW_S0 = 2'b11;

    // Define state register and next state logic
    reg [1:0] state, next_state;
    always @ (posedge clk or posedge reset)
    begin
        if (reset)
            state <= BELOW_S0;
        else
            state <= next_state;
    end
    
    // Output logic
    assign fr2 = (state == ABOVE_S2) ? 1'b0 : 1'b1;
    assign fr1 = (state == BETWEEN_S2_S1 || state == BETWEEN_S1_S0 || state == BELOW_S0) ? 1'b1 : 1'b0;
    assign fr0 = (state == BELOW_S0) ? 1'b1 : 1'b0;
    assign dfr = (state == BETWEEN_S1_S0 || state == BELOW_S0) ? 1'b1 : 1'b0;

    // State transition logic based on sensor inputs
    always @ (*)
    begin
        case(state)
            ABOVE_S2:
                if (s[2] == 1'b1)
                    next_state = BETWEEN_S2_S1;
                else
                    next_state = ABOVE_S2;
            BETWEEN_S2_S1:
                if (s[1] == 1'b1)
                    next_state = BETWEEN_S1_S0;
                else if (s[2] == 1'b0)
                    next_state = ABOVE_S2;
                else
                    next_state = BETWEEN_S2_S1;
            BETWEEN_S1_S0:
                if (s[0] == 1'b1)
                    next_state = BELOW_S0;
                else if (s[1] == 1'b0)
                    next_state = ABOVE_S2;
                else
                    next_state = BETWEEN_S1_S0;
            BELOW_S0:
                if (s[0] == 1'b0)
                    next_state = ABOVE_S2;
                else
                    next_state = BELOW_S0;
            default: next_state = ABOVE_S2;
        endcase
    end

endmodule
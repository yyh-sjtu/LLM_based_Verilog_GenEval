
module TopModule (
    input clk,
    input reset,
    input [2:0] s,
    output reg fr2,
    output reg fr1,
    output reg fr0,
    output reg dfr
);

// State parameter definitions
parameter STATE_ABOVE_S2 = 2'b00;
parameter STATE_BETWEEN_S21 = 2'b01;
parameter STATE_BETWEEN_S10 = 2'b10;
parameter STATE_BELOW_S0 = 2'b11;

// State and next state registers
reg [1:0] state, next_state;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_BELOW_S0;
    end else begin
        state <= next_state;
    end
end

// State machine logic
always @ (*) begin
    case(state)
        STATE_ABOVE_S2:
            begin
                fr2 = 0;
                fr1 = 0;
                fr0 = 0;
                if (s[1] & s[0])
                    next_state = STATE_BETWEEN_S21;
                else if (s[0])
                    next_state = STATE_BETWEEN_S10;
                else
                    next_state = STATE_BELOW_S0;
            end
        STATE_BETWEEN_S21:
            begin
                fr2 = 0;
                fr1 = 0;
                fr0 = 1;
                if (s[0])
                    next_state = STATE_BETWEEN_S10;
                else
                    next_state = STATE_BELOW_S0;
            end
        STATE_BETWEEN_S10:
            begin
                fr2 = 0;
                fr1 = 1;
                fr0 = 1;
                if (!s[0])
                    next_state = STATE_BELOW_S0;
                else
                    next_state = STATE_BETWEEN_S10;
            end
        STATE_BELOW_S0:
            begin
                fr2 = 1;
                fr1 = 1;
                fr0 = 1;
                if (s[1] & s[0])
                    next_state = STATE_BETWEEN_S21;
                else if (s[0])
                    next_state = STATE_BETWEEN_S10;
                else
                    next_state = STATE_BELOW_S0;
            end
    endcase
end

// Supplemental flow valve control
always @ (*) begin
    if (state == STATE_BETWEEN_S10 || state == STATE_BELOW_S0)
        dfr = 1;
    else
        dfr = 0;
end

endmodule
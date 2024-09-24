
module TopModule (
    input clk,
    input areset,
    input in,
    output reg out
);

// State enum
parameter A = 1'b0;
parameter B = 1'b1;

// State register and next state logic
reg state, next_state;

// Set initial state
always @* begin
    if (areset)
        state = B;
    else
        state = next_state;
end

// State transition logic
always @* begin
    case(state)
        A: begin
            case(in)
                1'b0: next_state = B;
                1'b1: next_state = A;
            endcase
        end
        B: begin
            case(in)
                1'b0: next_state = A;
                1'b1: next_state = B;
            endcase
        end
    endcase
end

// Output logic
always @* begin
    out = state;
end

endmodule
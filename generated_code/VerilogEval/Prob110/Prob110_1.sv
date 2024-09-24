
module TopModule (
    input clk,
    input areset,
    input j,
    input k,
    output reg out
);

// Define states
parameter OFF = 0;
parameter ON = 1;

// Define state register
reg [1:0] state, next_state;

// Moore state machine logic
always @ (posedge clk or posedge areset)
begin
    if (areset)
        state <= OFF;
    else
        state <= next_state;
end

always @ (*)
begin
    case (state)
        OFF: begin
            if (j)
                next_state = ON;
            else
                next_state = OFF;
        end
        ON: begin
            if (k)
                next_state = OFF;
            else
                next_state = ON;
        end
        default: next_state = state;
    endcase
end

// Output logic
always @ (*)
begin
    case (state)
        OFF: out = 0;
        ON: out = 1;
        default: out = 0;
    endcase
end

endmodule
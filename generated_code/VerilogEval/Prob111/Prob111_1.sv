
module TopModule (
    input clk,
    input reset,
    input j,
    input k,
    output reg out
);

// Define states
parameter OFF = 1'b0;
parameter ON = 1'b1;
reg state, next_state;

// State register
always@(posedge clk or posedge reset)
begin
    if (reset)
        state <= OFF;
    else
        state <= next_state;
end

// State transition and output logic
always@*
begin
    case(state)
        OFF: begin
            if (j)
                next_state = ON;
            else
                next_state = OFF;
            out = OFF;
        end
        ON: begin
            if (k)
                next_state = OFF;
            else
                next_state = ON;
            out = ON;
        end
        default: begin
            next_state = OFF;
            out = OFF;
        end
    endcase
end

endmodule
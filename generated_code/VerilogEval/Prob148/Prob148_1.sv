
module TopModule (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define state register
reg [1:0] state, next_state;

// State transition logic
always @ (posedge clk or negedge resetn)
begin
    if (~resetn)
        state <= A;
    else
        state <= next_state;
end

// State logic and FSM outputs
always @ (*)
begin
    case (state)
        A:
            begin
                if (r[0] & ~r[1] & ~r[2])
                    next_state = B;
                else if (~r[0] & r[1] & ~r[2])
                    next_state = C;
                else
                    next_state = A;
            end
        B:
            begin
                if (r[0])
                    next_state = B;
                else
                    next_state = A;
            end
        C:
            begin
                if (r[1])
                    next_state = C;
                else
                    next_state = A;
            end
        default:
            next_state = A;
    endcase
end

// FSM outputs
always @ (*)
begin
    g[0] = (state == B) ? 1'b1 : 1'b0;
    g[1] = (state == C) ? 1'b1 : 1'b0;
    g[2] = 3'b0;
end

endmodule

module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define states of the FSM
parameter A = 2'b00;
parameter B = 2'b01;

// Define state register
reg [1:0] state, next_state;

// Define state transition logic
always @ (posedge clk or posedge reset)
begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Define next state logic and output z generation
always @ *
begin
    case (state)
        A: begin
            if (s == 1)
                next_state = B;
            else
                next_state = A;
            z <= 0;
        end
        B: begin
            if (w == 1) begin
                if ((w + s + w) == 2) // Check for two 1's in the next three clock cycles
                    z <= 1;
                else
                    z <= 0;
            end
            else
                z <= 0;
            next_state = B;
        end
        default: begin
            next_state = A;
            z <= 0;
        end
    endcase
end

endmodule
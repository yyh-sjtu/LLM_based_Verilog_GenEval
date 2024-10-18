
module TopModule (
    input clk,
    input areset,
    input x,
    output reg z
);

// State encoding
parameter A = 1'b1;
parameter B = 1'b0;

// State register
reg state, next_state;

// Output logic
always @ (state, x)
begin
    case(state)
        A: if (x) z = 1'b1;
           else z = 1'b0;
        B: if (x) z = 1'b0;
           else z = 1'b1;
    endcase
end

// State transition logic
always @ (posedge clk or posedge areset)
begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @ (*)
begin
    case(state)
        A: if (x) next_state = B;
           else next_state = A;
        B: if (x) next_state = B;
           else next_state = B;
    endcase
end

endmodule
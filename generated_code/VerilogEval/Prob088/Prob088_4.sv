
module TopModule (
    input clk,
    input areset,
    input x,
    output reg z
);

// Declare the states using one-hot encoding
parameter A = 1'b1;
parameter B = 1'b0;

// Declare state and next_state registers
reg state, next_state;

// State always block
always @ (posedge clk or posedge areset)
begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

// Next state logic
always @ (*)
begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (x)
                next_state = B;
            else
                next_state = B;
        end
    endcase
end

// Output logic
always @ (*)
begin
    case (state)
        A: z = 1'b0;
        B: z = 1'b1;
    endcase
end

endmodule
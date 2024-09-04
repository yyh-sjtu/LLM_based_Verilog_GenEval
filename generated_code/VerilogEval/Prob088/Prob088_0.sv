
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

// State transition and output logic
always @ (posedge clk or posedge areset)
begin
    if (areset)
        state <= A;
    else
        state <= next_state;
end

always @ (*)
begin
    case (state)
        A: begin
            if (x)
                begin
                    z <= 1'b1;
                    next_state <= B;
                end
            else
                begin
                    z <= 1'b0;
                    next_state <= A;
                end
        end
        B: begin
            if (x)
                begin
                    z <= 1'b0;
                    next_state <= B;
                end
            else
                begin
                    z <= 1'b1;
                    next_state <= B;
                end
        end
    endcase
end

endmodule
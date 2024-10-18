
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

// State declaration
parameter B = 1'b0;
parameter A = 1'b1;

// State register
reg state_reg, next_state;

// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state_reg <= B;
    end else begin
        state_reg <= next_state;
    end
end

// Output logic
always @(*) begin
    case (state_reg)
        B: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
            out = 1;
        end
        A: begin
            if (in) begin
                next_state = A;
            end else begin
                next_state = B;
            end
            out = 0;
        end
    endcase
end

endmodule
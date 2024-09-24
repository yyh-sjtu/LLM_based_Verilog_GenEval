
module TopModule (
    input clk,
    input reset,
    input j,
    input k,
    output reg out
);

// State definition
parameter OFF = 1'b0;
parameter ON = 1'b1;
reg state, next_state;

// State machine logic
always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
    end else begin
        state <= next_state;
    end
end

always @(state, j, k) begin
    case(state)
        OFF: begin
            if (j) begin
                next_state = ON;
            end else begin
                next_state = OFF;
            end
        end
        ON: begin
            if (k) begin
                next_state = OFF;
            end else begin
                next_state = ON;
            end
        end
    endcase
end

// Output assignment
always @(state) begin
    case(state)
        OFF: out = 1'b0;
        ON: out = 1'b1;
    endcase
end

endmodule
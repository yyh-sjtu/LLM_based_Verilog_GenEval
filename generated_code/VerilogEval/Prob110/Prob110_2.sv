
module TopModule (
    input clk,
    input areset,
    input j,
    input k,
    output reg out
);

// Define states
parameter OFF = 1'b0;
parameter ON = 1'b1;

// Define state register
reg state_reg, next_state_reg;

// Next state logic
always @ (posedge clk or negedge areset) begin
    if (areset) begin
        state_reg <= OFF;
    end else begin
        state_reg <= next_state_reg;
    end
end

// State transition logic
always @ (*) begin
    case (state_reg)
        OFF: begin
            if (j) begin
                next_state_reg = ON;
            end else begin
                next_state_reg = OFF;
            end
        end
        ON: begin
            if (k) begin
                next_state_reg = OFF;
            end else begin
                next_state_reg = ON;
            end
        end
        default: next_state_reg = OFF;
    endcase
end

// Output logic
always @ (*) begin
    case (state_reg)
        OFF: out = 1'b0;
        ON: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule

module TopModule (
    input clk,
    input reset,
    input j,
    input k,
    output reg out
);

// Define states
parameter OFF = 2'b00;
parameter ON = 2'b01;

// State register
reg [1:0] state, next_state;

// Moore state machine logic
always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        OFF: begin
            if (j) begin
                next_state = ON;
            end else begin
                next_state = OFF;
            end
            out = 1'b0;
        end
        ON: begin
            if (k) begin
                next_state = OFF;
            end else begin
                next_state = ON;
            end
            out = 1'b1;
        end
        default: next_state = OFF;
    endcase
end

endmodule

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

// Define state register
reg [1:0] state, next_state;

// Moore state machine
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= OFF;
    end else begin
        state <= next_state;
    end
end

// State transitions based on inputs
always @(*) begin
    case (state)
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
        default: next_state = OFF;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        OFF: out = 1'b0;
        ON: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
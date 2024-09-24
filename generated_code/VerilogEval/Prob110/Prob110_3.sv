
module TopModule (
    input clk,
    input areset,
    input j,
    input k,
    output reg out
);

// State definition
localparam OFF = 2'b00;
localparam ON = 2'b01;

// State register
reg [1:0] state, next_state;

// Outputs
always @(*) begin
    case(state)
        OFF: begin
            if(j)
                next_state = ON;
            else
                next_state = OFF;
        end
        ON: begin
            if(k)
                next_state = OFF;
            else
                next_state = ON;
        end
    endcase
end

// State transition
always @(posedge clk or posedge areset) begin
    if(areset)
        state <= OFF;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    case(state)
        OFF: out = 1'b0;
        ON: out = 1'b1;
    endcase
end

endmodule
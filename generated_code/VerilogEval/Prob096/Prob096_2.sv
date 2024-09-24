
module TopModule (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define states for the finite-state machine
parameter IDLE = 2'd0;
parameter S1 = 2'd1;
parameter S2 = 2'd2;
parameter S3 = 2'd3;
parameter FOUND = 2'd4;

// Define state register and next state logic
reg [1:0] state, next_state;

always @ (posedge clk or posedge reset)
begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

always @ (*)
begin
    next_state = state;
    start_shifting = 0;

    case (state)
        IDLE: begin
            if (data)
                next_state = S1;
        end
        S1: begin
            if (data)
                next_state = S1;
            else
                next_state = S2;
        end
        S2: begin
            if (data)
                next_state = S1;
            else
                next_state = S3;
        end
        S3: begin
            if (data)
                next_state = FOUND;
        end
        FOUND: begin
            start_shifting = 1;
            next_state = FOUND;
        end
    endcase
end

endmodule
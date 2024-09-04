
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

// Define states
parameter B = 1'b0;
parameter A = 1'b1;

// Define state register
reg state, next_state;

// Define output register
reg next_out;

// Synchronous reset
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= B;
    else
        state <= next_state;
end

// Next state and output logic
always @(*)
begin
    case (state)
        B: begin
            next_state = (in) ? B : A;
            next_out = 1;
        end
        A: begin
            next_state = (in) ? A : B;
            next_out = 0;
        end
        default: begin
            next_state = B;
            next_out = 1;
        end
    endcase
end

// Assign next state and output to current state and output
always @(posedge clk)
begin
    state <= next_state;
    out <= next_out;
end

endmodule
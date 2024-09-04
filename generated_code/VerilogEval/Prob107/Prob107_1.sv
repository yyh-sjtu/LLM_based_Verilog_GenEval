
module TopModule(
    input clk,
    input reset,
    input in,
    output reg out
);

// Define state enumeration
typedef enum {B, A} state_type;
reg [1:0] state, next_state;

// State register
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= B;
    else
        state <= next_state;
end

// Next state logic
always @(*)
begin
    case (state)
        B: begin
            if (in)
                next_state = B;
            else
                next_state = A;
        end
        A: begin
            if (in)
                next_state = A;
            else
                next_state = B;
        end
        default: next_state = B;
    endcase
end

// Output logic
always @(*)
begin
    case (state)
        B: out = 1;
        A: out = 0;
        default: out = 1;
    endcase
end

endmodule
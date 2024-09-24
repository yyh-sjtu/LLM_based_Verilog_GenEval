
module TopModule(
    input clk,
    input reset,
    input x,
    output reg z
);

// Define states
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

// Define state register
reg [2:0] state, next_state;

// Assign initial state
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end

// Define next state logic
always @(*)
begin
    case(state)
        S0: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
            z = 0;
        end
        S1: begin
            if (x)
                next_state = S0;
            else
                next_state = S4;
            z = 0;
        end
        S2: begin
            if (x)
                next_state = S1;
            else
                next_state = S2;
            z = 0;
        end
        S3: begin
            if (x)
                next_state = S2;
            else
                next_state = S3;
            z = 1;
        end
        S4: begin
            if (x)
                next_state = S4;
            else
                next_state = S1;
            z = 1;
        end
    endcase
end

endmodule
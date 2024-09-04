
module TopModule(
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define states
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// Define state register
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn)
begin
    if (~aresetn)
        state <= S0;
    else
        state <= next_state;
end

// Define state transitions and output logic
always @(*)
begin
    case(state)
        S0: begin
            if (x) begin
                next_state = S1;
                z = 0;
            end
            else begin
                next_state = S0;
                z = 0;
            end
        end
        S1: begin
            if (x) begin
                next_state = S2;
                z = 0;
            end
            else begin
                next_state = S0;
                z = 0;
            end
        end
        S2: begin
            if (x) begin
                next_state = S1;
                z = 1; // Output z is asserted to logic-1 when "101" sequence is detected
            end
            else begin
                next_state = S0;
                z = 0;
            end
        end
        default: next_state = S0;
    endcase
end

endmodule
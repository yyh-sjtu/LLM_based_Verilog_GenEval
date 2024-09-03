
module adv_fsm(
    input clk,
    input reset,
    input x,
    output reg z
);

parameter IDLE=2'b00, S1=2'b01, S10=2'b10, S101=2'b11;
reg [1:0] present_state, next_state;

always @ (posedge clk or posedge reset)
begin
    if (reset)
        present_state <= IDLE;
    else
        present_state <= next_state;
end

always @ (*)
begin
    case (present_state)
        IDLE: begin
            if (x)
                next_state = S1;
            else
                next_state = IDLE;
        end
        S1: begin
            if (!x)
                next_state = S10;
            else
                next_state = IDLE;
        end
        S10: begin
            if (x)
                next_state = S101;
            else
                next_state = IDLE;
        end
        S101: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

assign z = (present_state == S101);

endmodule
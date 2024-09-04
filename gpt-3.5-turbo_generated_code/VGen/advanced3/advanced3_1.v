
module adv_fsm(
    input clk,
    input reset,
    input x,
    output reg z
);

reg [1:0] present_state, next_state;
parameter IDLE=2'b00, S1=2'b01, S10=2'b10, S101=2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        present_state <= IDLE;
    end else begin
        present_state <= next_state;
    end
end

always @(*) begin
    case(present_state)
        IDLE: begin
            next_state = (x) ? S1 : IDLE;
        end
        S1: begin
            next_state = (x) ? IDLE : S10;
        end
        S10: begin
            next_state = (x) ? S101 : IDLE;
        end
        S101: begin
            next_state = IDLE;
        end
    endcase
end

assign z = (present_state == S101) ? 1 : 0;

endmodule
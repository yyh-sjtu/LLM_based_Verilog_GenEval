
module adv_fsm(
    input clk,
    input reset,
    input x,
    output reg z );

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
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = IDLE;
                end
            end
            S1: begin
                if (!x) begin
                    next_state = S10;
                end else begin
                    next_state = IDLE;
                end
            end
            S10: begin
                if (x) begin
                    next_state = S101;
                end else begin
                    next_state = IDLE;
                end
            end
            S101: begin
                next_state = IDLE;
            end
        endcase
    end

    always @(*) begin
        if (present_state == S101) begin
            z = 1;
        end else begin
            z = 0;
        end
    end

endmodule
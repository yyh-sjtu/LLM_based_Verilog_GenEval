module adv_fsm(
    input clk,
    input reset,
    input x,
    output reg z
); 

reg present_state, next_state;

// State parameters
parameter IDLE=0, S1=1, S10=2, S101=3;

always @ (posedge clk or posedge reset) begin
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
        default: begin
            next_state = IDLE;
        end
    endcase
end

always @ (*) begin
    if (present_state == S101) begin
        z = 1;
    end else begin
        z = 0;
    end
end

endmodule



module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

// State definitions
parameter IDLE = 2'b00;
parameter DETECT_PATTERN = 2'b01;
parameter SHIFT_IN = 2'b10;
parameter WAIT_DONE_COUNTING = 2'b11;
parameter NOTIFY_USER = 2'b100;

reg [1:0] state, next_state;

always @ (posedge clk or posedge reset)
begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// State transition and output logic
always @ *
begin
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;
    
    case (state)
        IDLE:
            begin
                if (data == 4'b1101)
                    next_state = DETECT_PATTERN;
                else
                    next_state = IDLE;
            end
        DETECT_PATTERN:
            begin
                shift_ena = 1'b1;
                next_state = SHIFT_IN;
            end
        SHIFT_IN:
            begin
                if (shift_ena == 4'b1111)
                    next_state = WAIT_DONE_COUNTING;
                else
                    next_state = SHIFT_IN;
            end
        WAIT_DONE_COUNTING:
            begin
                counting = 1'b1;
                if (done_counting)
                    next_state = NOTIFY_USER;
                else
                    next_state = WAIT_DONE_COUNTING;
            end
        NOTIFY_USER:
            begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = NOTIFY_USER;
            end
    endcase
end

endmodule
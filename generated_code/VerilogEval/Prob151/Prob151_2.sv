
module TopModule (
    input clk,
    input reset,
    input data,
    input done_counting,
    input ack,
    output reg shift_ena,
    output reg counting,
    output reg done
);

// States for the finite-state machine
parameter IDLE = 2'b00;
parameter DETECT_PATTERN = 2'b01;
parameter SHIFT_DATA = 2'b10;
parameter WAIT_COUNTING = 2'b11;

reg [1:0] state, next_state;

always @ (posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @ (*) begin
    shift_ena = 0;
    counting = 0;
    done = 0;

    case (state)
        IDLE: begin
            if (data & ~reset) begin
                if ((data << 3) == 4'b1101) begin
                    next_state = DETECT_PATTERN;
                end else begin
                    next_state = IDLE;
                end
            end else begin
                next_state = IDLE;
            end
        end
        DETECT_PATTERN: begin
            shift_ena = 1;
            next_state = SHIFT_DATA;
        end
        SHIFT_DATA: begin
            shift_ena = 1;
            if (shift_ena == 4) begin
                next_state = WAIT_COUNTING;
            end else begin
                next_state = SHIFT_DATA;
            end
        end
        WAIT_COUNTING: begin
            counting = 1;
            if (done_counting) begin
                done = 1;
                next_state = IDLE;
            end else begin
                next_state = WAIT_COUNTING;
            end
        end
    endcase
end

endmodule
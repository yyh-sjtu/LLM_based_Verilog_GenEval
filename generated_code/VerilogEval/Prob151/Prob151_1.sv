
module TopModule(
    input clk,
    input reset,
    input data,
    input done_counting,
    input ack,
    output reg shift_ena,
    output reg counting,
    output reg done
);

// States definition
parameter IDLE = 2'b00;
parameter DETECT_PATTERN = 2'b01;
parameter SHIFT_IN = 2'b10;
parameter WAIT_COUNTING = 2'b11;

// State register
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// State machine logic
always @* begin
    case(state)
        IDLE: begin
            if (data == 1 && $past(data) == 1) begin
                next_state = DETECT_PATTERN;
            end else begin
                next_state = IDLE;
            end
        end
        DETECT_PATTERN: begin
            if (data == 0) begin
                next_state = IDLE;
            end else begin
                next_state = SHIFT_IN;
            end
        end
        SHIFT_IN: begin
            if (shift_ena == 1) begin
                next_state = WAIT_COUNTING;
            end else begin
                next_state = SHIFT_IN;
            end
        end
        WAIT_COUNTING: begin
            if (done_counting == 1) begin
                next_state = IDLE;
            end else begin
                next_state = WAIT_COUNTING;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @* begin
    case(state)
        IDLE: begin
            shift_ena = 0;
            counting = 0;
            done = 0;
        end
        DETECT_PATTERN: begin
            shift_ena = 0;
            counting = 0;
            done = 0;
        end
        SHIFT_IN: begin
            shift_ena = (shift_ena == 4'b1111) ? 0 : 1;
            counting = 0;
            done = 0;
        end
        WAIT_COUNTING: begin
            shift_ena = 0;
            counting = 1;
            done = 0;
        end
        default: begin
            shift_ena = 0;
            counting = 0;
            done = 1;
        end
    endcase
end

endmodule
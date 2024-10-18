module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state;

    // Declare state constants
    parameter START = 4'b0000;
    parameter DETECT_PATTERN = 4'b0001;
    parameter WAIT_SHIFT_ENA = 4'b0010;
    parameter WAIT_COUNTING = 4'b0011;
    parameter TIMER_DONE = 4'b0100;
    parameter WAIT_ACK = 4'b0101;

    always @(posedge clk) begin
        if (reset) begin
            state <= START;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                START: begin
                    if (data == 4'b1101)
                        state <= DETECT_PATTERN;
                end

                DETECT_PATTERN: begin
                    state <= WAIT_SHIFT_ENA;
                    shift_ena <= 1;
                end

                WAIT_SHIFT_ENA: begin
                    state <= WAIT_COUNTING;
                    shift_ena <= 0;
                end

                WAIT_COUNTING: begin
                    if (done_counting)
                        state <= TIMER_DONE;
                    counting <= 1;
                end

                TIMER_DONE: begin
                    state <= WAIT_ACK;
                    done <= 1;
                end

                WAIT_ACK: begin
                    if (ack)
                        state <= START;
                end
            endcase
        end
    end
endmodule


module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State definitions
    parameter IDLE = 2'b00;
    parameter DETECTING_PATTERN = 2'b01;
    parameter SHIFTING_IN_BITS = 2'b10;
    parameter WAITING_FOR_COUNTERS = 2'b11;
    
    reg [1:0] state;
    reg [3:0] counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            counter <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECTING_PATTERN;
                    end
                end
                DETECTING_PATTERN: begin
                    state <= SHIFTING_IN_BITS;
                    shift_ena <= 1;
                end
                SHIFTING_IN_BITS: begin
                    if (counter == 4) begin
                        state <= WAITING_FOR_COUNTERS;
                        shift_ena <= 0;
                        counting <= 1;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end
                WAITING_FOR_COUNTERS: begin
                    if (done_counting) begin
                        state <= IDLE;
                        counting <= 0;
                        done <= 1;
                    end
                end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
        end else begin
            if (state == SHIFTING_IN_BITS) begin
                counter <= counter + 1;
            end
        end
    end

endmodule


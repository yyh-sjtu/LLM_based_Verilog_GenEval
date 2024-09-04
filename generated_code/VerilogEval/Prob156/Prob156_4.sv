
module TopModule (
    input clk,
    input reset,
    input data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input ack
);

parameter IDLE = 2'b00;
parameter DETECT_PATTERN = 2'b01;
parameter SHIFT_IN_DELAY = 2'b10;
parameter COUNTING = 2'b11;

reg [1:0] state;
reg [3:0] delay;
reg [3:0] remaining_time;

always @ (posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 4'b0000;
        counting <= 0;
        done <= 0;
        delay <= 4'b0000;
        remaining_time <= 4'b0000;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1 && $rose(data)) begin
                    state <= DETECT_PATTERN;
                end
            end
            DETECT_PATTERN: begin
                // Shift in delay
                delay <= {delay[2:0], data};
                state <= SHIFT_IN_DELAY;
            end
            SHIFT_IN_DELAY: begin
                state <= COUNTING;
                counting <= 1;
                remaining_time <= delay;
            end
            COUNTING: begin
                if (remaining_time == 0) begin
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        state <= IDLE;
                        count <= 4'bxxxx; // don't care value
                        done <= 0;
                    end
                end else begin
                    remaining_time <= remaining_time - 1;
                end
            end
        endcase
    end
end

endmodule
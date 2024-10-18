
module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    parameter IDLE = 2'b00;
    parameter DETECT_PATTERN = 2'b01;
    parameter SHIFT_IN_BITS = 2'b10;
    parameter COUNTING = 2'b11;

    reg [1:0] state;
    reg [3:0] delay;

    always @ (posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            delay <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= SHIFT_IN_BITS;
                    end
                end
                SHIFT_IN_BITS: begin
                    delay <= {data, delay[3:1]};
                    state <= COUNTING;
                    counting <= 1;
                end
                COUNTING: begin
                    if (counting) begin
                        if (count == delay) begin
                            done <= 1;
                            counting <= 0;
                        end
                        else begin
                            count <= count + 1;
                        end
                    end
                    else begin
                        if (ack) begin
                            state <= IDLE;
                            count <= 0;
                            done <= 0;
                        end
                    end
                end
            endcase
        end
    end

endmodule
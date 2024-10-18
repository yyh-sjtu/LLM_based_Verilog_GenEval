module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

// Internal signals
reg [3:0] delay;
reg [3:0] counter;
reg [1:0] state;

// State assignments
parameter IDLE = 2'b00;
parameter DETECT_START = 2'b01;
parameter COUNT = 2'b10;

// Default signal assignments
assign count = counting ? counter : 4'bzzzz; // don't care when not counting
assign done = counting && counter == 0;

// State machine
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE; // reset to initial state
        counting <= 0;
        counter <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    state <= DETECT_START;
                    counting <= 0;
                    counter <= 0;
                end
            end
            DETECT_START: begin
                delay <= data;
                state <= COUNT;
                counting <= 1;
                counter <= (delay + 1) * 1000;
            end
            COUNT: begin
                if (counter > 0) begin
                    counter <= counter - 1;
                end
                else begin
                    state <= IDLE;
                    counting <= 0;
                    counter <= 0;
                end
            end
        endcase
    end
end

endmodule


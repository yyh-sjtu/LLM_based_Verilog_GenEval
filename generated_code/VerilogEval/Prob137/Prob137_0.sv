
module TopModule (
    input clk,
    input reset,
    input in,
    output reg done
);

// Define states for the finite state machine
parameter IDLE = 2'd0;
parameter START_BIT = 2'd1;
parameter DATA_BITS = 2'd2;
parameter STOP_BIT = 2'd3;

reg [1:0] state;
reg [2:0] data;
reg start_detected;

always @ (posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
        start_detected <= 0;
        data <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (!in) begin
                    state <= START_BIT;
                    start_detected <= 1;
                    data <= 0;
                end
            end
            START_BIT: begin
                if (start_detected) begin
                    state <= DATA_BITS;
                end else begin
                    state <= IDLE;
                end
            end
            DATA_BITS: begin
                data <= {in, data[2:1]};
                if (data == 3'b100) begin
                    state <= STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in) begin
                    state <= IDLE;
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule

module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output reg [23:0] out_bytes,
    output reg done
);

// Define states for the finite state machine
parameter IDLE = 2'b00;
parameter BYTE1 = 2'b01;
parameter BYTE2 = 2'b10;
parameter BYTE3 = 2'b11;

// Define registers for the FSM
reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

// Default assignments
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
        out_bytes <= 24'b0;
    end else begin
        case(state)
            IDLE: begin
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= BYTE1;
                end
            end
            BYTE1: begin
                byte2 <= in;
                state <= BYTE2;
            end
            BYTE2: begin
                byte3 <= in;
                state <= BYTE3;
            end
            BYTE3: begin
                out_bytes <= {byte1, byte2, byte3};
                done <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
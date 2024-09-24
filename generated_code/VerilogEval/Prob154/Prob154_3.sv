
module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output reg [23:0] out_bytes,
    output reg done
);

// Define states
parameter IDLE = 2'b00;
parameter FIRST_BYTE = 2'b01;
parameter SECOND_BYTE = 2'b10;
parameter THIRD_BYTE = 2'b11;

// Define state register
reg [1:0] state, next_state;

// Define message received signal
reg message_received;

always @(*) begin
    case(state)
        IDLE: begin
            if(in[3] == 1)
                next_state = FIRST_BYTE;
            else
                next_state = IDLE;
        end
        FIRST_BYTE: next_state = SECOND_BYTE;
        SECOND_BYTE: next_state = THIRD_BYTE;
        THIRD_BYTE: begin
            next_state = IDLE;
            message_received = 1;
        end
        default: next_state = IDLE;
    endcase
end

always @(posedge clk) begin
    if(reset) begin
        state <= IDLE;
        message_received <= 0;
        done <= 0;
        out_bytes <= 0;
    end else begin
        state <= next_state;
        if(message_received) begin
            out_bytes[23:16] <= in;
            case(state)
                FIRST_BYTE: out_bytes[15:8] <= 8'b0;
                SECOND_BYTE: out_bytes[15:8] <= in;
                THIRD_BYTE: out_bytes[15:8] <= 8'b0;
            endcase
            done <= 1;
            message_received <= 0;
        end else begin
            done <= 0;
            out_bytes <= 24'b0;
        end
    end
end

endmodule
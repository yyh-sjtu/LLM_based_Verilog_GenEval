
module TopModule (
    input wire clk,
    input wire reset,
    input wire data,
    output reg start_shifting
);

// State definition
parameter IDLE = 2'b00;
parameter FOUND_1 = 2'b01;
parameter FOUND_11 = 2'b10;
parameter FOUND_110 = 2'b11;

// State register
reg [1:0] state, next_state;

always @ (posedge clk or posedge reset)
begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @ (*)
begin
    case(state)
        IDLE: begin
            if (data) begin
                next_state = FOUND_1;
            end else begin
                next_state = IDLE;
            end
        end
        FOUND_1: begin
            if (data) begin
                next_state = FOUND_11;
            end else begin
                next_state = IDLE;
            end
        end
        FOUND_11: begin
            if (data) begin
                next_state = FOUND_110;
            end else begin
                next_state = IDLE;
            end
        end
        FOUND_110: begin
            if (data) begin
                start_shifting = 1;
                next_state = FOUND_1;
            end else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
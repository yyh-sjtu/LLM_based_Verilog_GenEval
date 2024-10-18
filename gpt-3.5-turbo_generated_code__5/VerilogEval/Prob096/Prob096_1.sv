
module TopModule (
    input  clk,
    input  reset,
    input  data,
    output reg start_shifting
);

// Define states for the finite-state machine
parameter IDLE = 2'b00;
parameter SEARCH_1 = 2'b01;
parameter SEARCH_10 = 2'b10;
parameter SEARCH_110 = 2'b11;

// Define state register
reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(state, data) begin
    case (state)
        IDLE: begin
            if (data) begin
                next_state = SEARCH_1;
            end else begin
                next_state = IDLE;
            end
        end
        SEARCH_1: begin
            if (data) begin
                next_state = SEARCH_10;
            end else begin
                next_state = IDLE;
            end
        end
        SEARCH_10: begin
            if (data) begin
                next_state = SEARCH_110;
            end else begin
                next_state = IDLE;
            end
        end
        SEARCH_110: begin
            if (data) begin
                next_state = SEARCH_1;
                start_shifting = 1;
            end else begin
                next_state = IDLE;
                start_shifting = 0;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
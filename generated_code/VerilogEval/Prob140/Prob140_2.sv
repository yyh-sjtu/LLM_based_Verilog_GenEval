
module TopModule (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define states
parameter IDLE = 2'b00;
parameter FOUND_1 = 2'b01;
parameter FOUND_2 = 2'b10;

// Internal signals
reg [1:0] state, next_state;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @* begin
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        IDLE: begin
            if (in) begin
                next_state = FOUND_1;
            end else begin
                next_state = IDLE;
            end
        end

        FOUND_1: begin
            if (in) begin
                next_state = FOUND_2;
            end else begin
                next_state = IDLE;
            end
        end

        FOUND_2: begin
            if (in) begin
                err = 1;
                next_state = IDLE;
            end else begin
                disc = 1;
                flag = 1;
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
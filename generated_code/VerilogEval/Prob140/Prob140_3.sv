
module TopModule (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define FSM states
parameter IDLE = 2'b00;
parameter FIVE_ONES = 2'b01;
parameter FLAG_DETECTED = 2'b10;
parameter ERROR = 2'b11;

// Declare state and next state registers
reg [1:0] state, next_state;

// Synchronous reset behavior
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// FSM logic
always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;

    case (state)
        IDLE: begin
            if (in) begin
                next_state = FIVE_ONES;
            end else begin
                next_state = IDLE;
            end
        end

        FIVE_ONES: begin
            if (in) begin
                next_state = FLAG_DETECTED;
            end else begin
                next_state = IDLE;
            end
        end

        FLAG_DETECTED: begin
            if (in) begin
                next_state = ERROR;
            end else begin
                next_state = IDLE;
            end
        end

        ERROR: begin
            if (in) begin
                next_state = ERROR;
            end else begin
                next_state = IDLE;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        FIVE_ONES: begin
            disc = 1;
        end

        FLAG_DETECTED: begin
            flag = 1;
        end

        ERROR: begin
            err = 1;
        end
    endcase
end

endmodule
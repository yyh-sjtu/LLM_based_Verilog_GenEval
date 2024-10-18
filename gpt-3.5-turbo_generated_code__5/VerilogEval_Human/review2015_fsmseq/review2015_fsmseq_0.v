
module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define states
typedef enum logic [3:0] {
    IDLE,
    S1,
    S2,
    S3,
    FOUND
} state_t;

// Declare state registers
reg [3:0] current_state, next_state;

// Start shifting flag
reg start_shift;

// Define sequence to search for
localparam [3:0] SEQ_1101 = 4'b1101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        start_shift <= 0;
    end else begin
        current_state <= next_state;
        start_shift <= (current_state == FOUND);
    end
end

always @(current_state or data) begin
    next_state = current_state;
    case (current_state)
        IDLE:
            if (data == 1'b1)
                next_state = S1;
        S1:
            if (data == 1'b1)
                next_state = S2;
            else
                next_state = IDLE;
        S2:
            if (data == 1'b1)
                next_state = S3;
            else
                next_state = IDLE;
        S3:
            if (data == 1'b0)
                next_state = FOUND;
            else
                next_state = IDLE;
        FOUND:
            next_state = IDLE;
    endcase
end

assign start_shifting = start_shift;

endmodule
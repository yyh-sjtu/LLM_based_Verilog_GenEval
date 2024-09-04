
module TopModule (
    input clk,
    input reset,
    input [2:0] s,
    output fr2,
    output fr1,
    output fr0,
    output dfr
);

// Define states for the state machine
parameter STATE_LOW = 2'b00;
parameter STATE_BETWEEN_1_0 = 2'b01;
parameter STATE_BETWEEN_2_1 = 2'b10;
parameter STATE_HIGH = 2'b11;

reg [1:0] state, next_state;
reg [1:0] prev_state;

// Outputs
assign fr2 = (state == STATE_HIGH) ? 1'b0 : 1'b1;
assign fr1 = (state == STATE_HIGH || state == STATE_BETWEEN_1_0) ? 1'b0 : 1'b1;
assign fr0 = (state == STATE_HIGH || state == STATE_BETWEEN_1_0 || state == STATE_BETWEEN_2_1) ? 1'b0 : 1'b1;
assign dfr = (state == STATE_BETWEEN_2_1 || state == STATE_LOW) ? 1'b1 : 1'b0;

// State machine process
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_LOW;
        prev_state <= STATE_LOW;
    end else begin
        prev_state <= state;
        state <= next_state;
    end
end

// State transition logic based on water level sensors
always @* begin
    case({prev_state, s})
        2'b000: next_state = STATE_LOW;
        2'b001: next_state = STATE_BETWEEN_1_0;
        2'b010: next_state = STATE_BETWEEN_2_1;
        2'b011: next_state = STATE_HIGH;
        default: next_state = STATE_LOW;
    endcase
end

endmodule

module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

// FSM states
parameter IDLE = 2'b00;
parameter STATE1 = 2'b01;
parameter STATE2 = 2'b10;

reg [1:0] state, next_state;

// Sequential logic
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        state <= IDLE;
        MATCH <= 0;
    end else begin
        state <= next_state;
        MATCH <= (state == STATE2);
    end
end

// Combinational logic
always @(state, IN) begin
    case (state)
        IDLE:
            if (IN)
                next_state = STATE1;
            else
                next_state = IDLE;
        STATE1:
            if (IN)
                next_state = STATE1;
            else
                next_state = STATE2;
        STATE2:
            if (IN)
                next_state = STATE1;
            else
                next_state = IDLE;
        default:
            next_state = IDLE;
    endcase
end

endmodule
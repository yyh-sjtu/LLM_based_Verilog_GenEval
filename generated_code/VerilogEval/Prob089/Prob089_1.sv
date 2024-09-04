
module TopModule (
    input clk,
    input areset,
    input x,
    output reg z
);

// State definition
typedef enum logic [1:0] {
    IDLE = 2'b00,
    CONVERT = 2'b01
} state_t;

// State and next state signals
reg [1:0] state, next_state;

// Reset logic
always @(posedge clk or posedge areset)
begin
    if (areset)
        state <= IDLE;
    else
        state <= next_state;
end

// State machine logic
always @*
begin
    case(state)
        IDLE:
            begin
                if (!areset && x == 1'b1)
                    next_state = CONVERT;
                else
                    next_state = IDLE;
            end
        CONVERT:
            begin
                if (!areset && x == 1'b0)
                    next_state = IDLE;
                else
                    next_state = CONVERT;
            end
    endcase
end

// Output logic
always @*
begin
    case(state)
        IDLE:
            z = 1'b0;
        CONVERT:
            z = ~z;
    endcase
end

endmodule
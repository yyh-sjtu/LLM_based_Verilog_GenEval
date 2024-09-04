
module fsm (
    input wire IN,
    input wire CLK,
    input wire RST,
    output reg MATCH
);

// Define states
parameter IDLE = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter MATCH_STATE = 2'b11;

// Define signals
reg [1:0] state, next_state;

// Define state transition logic
always @ (state, IN)
begin
    case (state)
    IDLE: begin
        if (IN)
            next_state = S1;
        else
            next_state = IDLE;
    end
    S1: begin
        if (!IN)
            next_state = IDLE;
        else
            next_state = S2;
    end
    S2: begin
        if (IN)
            next_state = MATCH_STATE;
        else
            next_state = IDLE;
    end
    MATCH_STATE: begin
        if (IN)
            next_state = MATCH_STATE;
        else
            next_state = IDLE;
    end
    endcase
end

// Define state register
always @ (posedge CLK or posedge RST)
begin
    if (RST)
        state <= IDLE;
    else
        state <= next_state;
end

// Define output logic
always @ (state)
begin
    case (state)
    IDLE: MATCH <= 0;
    S1: MATCH <= 0;
    S2: MATCH <= 0;
    MATCH_STATE: MATCH <= 1;
    endcase
end

endmodule
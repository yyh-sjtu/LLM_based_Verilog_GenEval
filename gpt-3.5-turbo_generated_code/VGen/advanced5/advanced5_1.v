
module abro(
    input clk,
    input reset,
    input a,
    input b,
    output reg z
);

// State definitions
parameter IDLE = 2'b00,
          SA   = 2'b01,
          SB   = 2'b10,
          SAB  = 2'b11;

// State registers
reg [1:0] cur_state, next_state;

// State transition logic
always @(*) begin
    case (cur_state)
        IDLE: begin
            if (a) 
                next_state = SA;
            else if (b)
                next_state = SB;
            else 
                next_state = IDLE;
        end
        SA: begin
            if (b) 
                next_state = SAB; // Transition to SAB if b is received
            else 
                next_state = SA; // Stay in SA if only a is high
        end
        SB: begin
            if (a) 
                next_state = SAB; // Transition to SAB if a is received
            else 
                next_state = SB; // Stay in SB if only b is high
        end
        SAB: begin
            // Once in SAB, we stay here until reset
            next_state = SAB;
        end
        default: next_state = IDLE; // Default case
    endcase
end

// Output logic
always @(*) begin
    if (cur_state == SAB) 
        z = 1;    // Output high when in SAB state
    else 
        z = 0;    // Output low otherwise
end

// State update logic
always @(posedge clk or posedge reset) begin
    if (reset) 
        cur_state <= IDLE; // Reset to IDLE state
    else 
        cur_state <= next_state; // Update current state to next state
end

endmodule
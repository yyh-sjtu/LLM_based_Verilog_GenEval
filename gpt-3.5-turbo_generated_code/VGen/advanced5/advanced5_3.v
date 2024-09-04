
module abro(
    input clk,
    input reset,
    input a,
    input b,
    output reg z
);
    parameter IDLE = 2'b00,
              SA   = 2'b01,
              SB   = 2'b10,
              SAB  = 2'b11;

    reg [1:0] cur_state, next_state;

    // Sequential logic: State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            cur_state <= IDLE; // Reset state
        else
            cur_state <= next_state; // Transition to next state
    end

    // Combinational logic: Next state logic and output logic
    always @(*) begin
        case (cur_state)
            IDLE: begin
                if (a) 
                    next_state = SA;  // Move to state SA if received a
                else if (b) 
                    next_state = SB;  // Move to state SB if received b
                else 
                    next_state = IDLE; // Remain in IDLE
                z = 0; // Output z is 0 in IDLE state
            end

            SA: begin
                if (b) 
                    next_state = SAB; // Move to state SAB if received b
                else 
                    next_state = SA;  // Remain in state SA
                z = 0; // Output z is 0 in SA state
            end
            
            SB: begin
                if (a) 
                    next_state = SAB; // Move to state SAB if received a
                else 
                    next_state = SB;  // Remain in state SB
                z = 0; // Output z is 0 in SB state
            end

            SAB: begin
                next_state = SAB; // Stay in SAB state once both a and b received
                z = 1; // Output z is 1 in SAB state
            end

            default: begin
                next_state = IDLE; // In case of an unexpected state
                z = 0; // Default output
            end
        endcase
    end

endmodule
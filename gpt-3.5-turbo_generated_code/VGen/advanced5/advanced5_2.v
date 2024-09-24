
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
    
    // Synchronous state transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cur_state <= IDLE;
            z <= 0;
        end else begin
            cur_state <= next_state;
        end
    end

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
                z = 0; // Output is 0
            end

            SA: begin
                if (b) 
                    next_state = SAB;
                else
                    next_state = SA; // stay in SA if a is still high
                z = 0; // Output is still 0
            end

            SB: begin
                if (a) 
                    next_state = SAB;
                else
                    next_state = SB; // stay in SB if b is still high
                z = 0; // Output is still 0
            end

            SAB: begin
                next_state = SAB; // Stay in SAB
                z = 1; // Output is 1 when both a and b have been received
            end
            
            default: begin
                next_state = IDLE;
                z = 0; // Default error handling
            end
        endcase
    end
endmodule
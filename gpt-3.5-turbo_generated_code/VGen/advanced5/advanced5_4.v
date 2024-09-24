
module abro(
    input clk,
    input reset,
    input a,
    input b,
    output reg z
);
    // State encoding
    parameter IDLE = 2'b00,
              SA   = 2'b01,
              SB   = 2'b10,
              SAB  = 2'b11;

    reg [1:0] cur_state, next_state;

    // Sequential logic: State update at every clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) 
            cur_state <= IDLE; // Reset state
        else 
            cur_state <= next_state; // Transition to next state
    end

    // Combinatorial logic: Next state and output logic
    always @(*) begin
        // Default values
        next_state = cur_state;
        z = 0; // Default output is 0

        case (cur_state)
            IDLE: begin
                if (a) next_state = SA; // Move to SA if a is received
                else if (b) next_state = SB; // Move to SB if b is received
            end
            SA: begin
                if (b) next_state = SAB; // Move to SAB if b is received
                z = 1; // Output 1 when we are in SA
            end
            SB: begin
                if (a) next_state = SAB; // Move to SAB if a is received
                z = 1; // Output 1 when we are in SB
            end
            SAB: begin
                z = 1; // Output 1 when both signals a and b have been received
            end
        endcase
    end
endmodule

module TopModule (
    input wire x,
    input wire [2:0] y,
    output reg Y0,
    output reg z
);

// Define the next state based on the current state and input x
reg [2:0] next_state;

always @(*) begin
    // Default values
    next_state = 3'b000; // Initial next state
    z = 1'b0;            // Default output z

    case (y)
        3'b000: begin
            if (x == 1'b0) next_state = 3'b000; // Stay in state 000 with x = 0
            else next_state = 3'b001;          // Move to state 001 with x = 1
        end 
        
        3'b001: begin
            if (x == 1'b0) next_state = 3'b001; // Stay in state 001 with x = 0
            else next_state = 3'b100;          // Move to state 100 with x = 1
        end 
        
        3'b010: begin
            if (x == 1'b0) next_state = 3'b010; // Stay in state 010 with x = 0
            else next_state = 3'b001;          // Move to state 001 with x = 1
        end 
        
        3'b011: begin
            if (x == 1'b0) next_state = 3'b001; // Move to state 001 with x = 0
            else next_state = 3'b010;          // Move to state 010 with x = 1
            z = 1'b1; // Output z = 1
        end 
        
        3'b100: begin
            if (x == 1'b0) next_state = 3'b011; // Move to state 011 with x = 0
            else next_state = 3'b100;          // Stay in state 100 with x = 1
            z = 1'b1; // Output z = 1
        end 
        
        default: begin
            next_state = 3'b000; // Default case (reset)
        end
    endcase

    // Assign the output Y0 as the least significant bit of the next state
    Y0 = next_state[0];
end

endmodule
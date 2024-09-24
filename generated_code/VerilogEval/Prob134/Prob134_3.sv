
module TopModule (
    input wire x,
    input wire [2:0] y,
    output reg Y0,
    output reg z
);

    // Declare the next state variable
    reg [2:0] next_state;

    // Combinatorial logic for next state and output
    always @(*) begin
        // Default values
        next_state = y; // Hold the current state by default
        z = 0;          // Default output for z
        Y0 = next_state[0]; // Y0 is the least significant bit of the next state
        
        case (y)
            3'b000: begin
                if (x) begin
                    next_state = 3'b001; // y = 000, x = 1 -> next state = 001
                end else begin
                    next_state = 3'b000; // y = 000, x = 0 -> next state = 000
                end
                z = 0; // Output z remains 0
            end
            
            3'b001: begin
                if (x) begin
                    next_state = 3'b100; // y = 001, x = 1 -> next state = 100
                end else begin
                    next_state = 3'b001; // y = 001, x = 0 -> next state = 001
                end
                z = 0; // Output z remains 0
            end
            
            3'b010: begin
                if (x) begin
                    next_state = 3'b001; // y = 010, x = 1 -> next state = 001
                end else begin
                    next_state = 3'b010; // y = 010, x = 0 -> next state = 010
                end
                z = 0; // Output z remains 0
            end
            
            3'b011: begin
                if (x) begin
                    next_state = 3'b010; // y = 011, x = 1 -> next state = 010
                end else begin
                    next_state = 3'b001; // y = 011, x = 0 -> next state = 001
                end
                z = 1; // Output z set to 1
            end
            
            3'b100: begin
                if (x) begin
                    next_state = 3'b100; // y = 100, x = 1 -> next state = 100
                end else begin
                    next_state = 3'b011; // y = 100, x = 0 -> next state = 011
                end
                z = 1; // Output z set to 1
            end
            
            default: begin
                next_state = 3'b000; // default state
                z = 0; // output z set to default
            end
        endcase
    end

    // Sequential logic to hold the state
    always @(posedge clk) begin
        y <= next_state;
    end

endmodule
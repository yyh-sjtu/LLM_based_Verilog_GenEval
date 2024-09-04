
module lfsr(
    input clk,
    input reset,
    output reg [4:0] q
);
    
    // Wires to hold the next value and feedback value
    wire feedback_value;
    
    // Feedback calculation using XOR of the specified tap positions (5 and 3)
    assign feedback_value = r_reg[4] ^ r_reg[2]; // Taps at bits 5 and 3 (counting from 1)
    
    // The next state of the register
    assign r_next = {r_reg[3:0], feedback_value}; // Shift left and insert feedback in LSB

    // Register to hold the current state
    reg [4:0] r_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_reg <= 5'b00001; // Set to a non-zero state (initial state)
        end else begin
            r_reg <= r_next; // Update the register with the next state
        end
    end

    // Output the current state
    always @(posedge clk) begin
        q <= r_reg; // Update the output q
    end

endmodule
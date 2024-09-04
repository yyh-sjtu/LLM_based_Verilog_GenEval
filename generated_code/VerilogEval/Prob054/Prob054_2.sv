
module TopModule (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    // Create a register to hold the previous state of 'in'
    reg [7:0] prev_in;

    always @(posedge clk) begin
        // Check for positive edge detection
        pedge <= in & ~prev_in;  // Set 'pedge' to 1 where 'in' is 1 and 'prev_in' is 0
        prev_in <= in;           // Update the previous state to the current state
    end

endmodule
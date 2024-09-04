
module right_shifter (
    input clk,    // Clock signal
    input d,      // Input signal to be right-shifted
    output reg [7:0] q    // Output signal representing the result of the right shift operation
);

    // Initialize q register to 0
    initial begin
        q <= 8'b0;
    end

    // Perform right shift operation on rising edge of the clock
    always @(posedge clk) begin
        q <= (q >> 1);    // Right shift q by 1 bit
        q[7] <= d;        // Insert new input bit d into the most significant position
    end

endmodule
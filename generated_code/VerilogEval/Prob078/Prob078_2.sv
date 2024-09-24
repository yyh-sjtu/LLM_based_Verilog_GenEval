
module TopModule (
    input clk,        // Clock input
    input d,          // Data input
    output reg q      // Data output
);

    reg d_latch;      // Intermediate latch to hold the value of 'd'

    always @(posedge clk) begin
        d_latch <= d; // Latch the data on the rising edge of clk
        q <= d_latch; // Output 'q' receives the value of 'd_latch'
    end
    
    always @(negedge clk) begin
        q <= d;       // Output 'q' receives the value of 'd' on falling edge
    end

endmodule
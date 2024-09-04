
module TopModule (
    input wire d,    // Data input
    input wire ena,  // Enable signal
    output reg q     // Output
);

// Always block triggered by changes in 'd' or 'ena'
always @(*) begin
    if (ena) begin
        q = d; // When enabled, output follows the input
    end 
    // If ena is low, q retains its value (i.e., latch behavior)
end

endmodule
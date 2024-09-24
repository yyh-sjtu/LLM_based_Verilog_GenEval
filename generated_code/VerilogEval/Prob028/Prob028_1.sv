
module TopModule (
    input  wire d,     // Data input
    input  wire ena,   // Enable signal
    output reg  q      // Output
);

    // D latch implementation
    always @* begin
        if (ena) begin
            q = d;     // When enabled, output follows input
        end
        // If 'ena' is low, the output 'q' retains its previous value
    end

endmodule

module TopModule (
    input  wire clk, // Clock input
    input  wire w,   // Input from the previous stage
    input  wire R,   // Value to load (will be treated as the new value)
    input  wire E,   // Enable shift
    input  wire L,   // Load signal
    output reg  Q    // Output value
);

    always @(posedge clk) begin
        if (L) begin
            // Load new value R into Q when L is asserted
            Q <= R;
        end else if (E) begin
            // Shift in the value from the previous stage (input w)
            Q <= w;
        end
        // If neither L nor E is asserted, Q retains its current value
    end
endmodule
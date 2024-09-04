
module TopModule (
    input  wire clk,    // Clock input
    input  wire w,      // Input from the previous stage
    input  wire R,      // Value to load (High for load)
    input  wire E,      // Enable shift (High for shifting)
    input  wire L,      // Load signal (High for loading)
    output reg  Q       // Output
);

    always @(posedge clk) begin
        if (L) begin
            // Load the value R into Q if L is asserted
            Q <= R;
        end else if (E) begin
            // Shift the value from the previous stage if E is asserted
            Q <= w;
        end
        // If neither L nor E are asserted, Q retains its previous value
    end

endmodule
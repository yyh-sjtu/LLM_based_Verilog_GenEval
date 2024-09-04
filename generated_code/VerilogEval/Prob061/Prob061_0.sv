
module TopModule (
    input  wire clk,  // Clock input
    input  wire w,    // Input from previous stage
    input  wire R,    // Load value input
    input  wire E,    // Enable shift input
    input  wire L,    // Load input
    output reg  Q     // Output value
);

    always @(posedge clk) begin
        if (L) begin
            // Load the value R into Q when L is asserted
            Q <= R;
        end else if (E) begin
            // Enable shifting: Shift Q by one position, assuming w is the new bit
            Q <= w;
        end
        // If neither L nor E are asserted, retain the current value of Q
    end

endmodule
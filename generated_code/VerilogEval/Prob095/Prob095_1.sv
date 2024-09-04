
module TopModule (
    input  clk,
    input  reset,
    output reg shift_ena
);

    // State declaration
    reg [2:0] count;  // To count the number of cycles (3 bits for counting 0 to 7)

    always @(posedge clk) begin
        // Synchronous reset logic
        if (reset) begin
            count <= 0;    // Reset the counter
            shift_ena <= 1; // Enable shift for the first cycle
        end else begin
            // Check if we have counted to 4 cycles
            if (count < 4) begin
                shift_ena <= 1; // Keep shift_ena high
                count <= count + 1; // Increment the counter
            end else begin
                shift_ena <= 0; // Disable shift_ena after 4 cycles
            end
        end
    end

endmodule
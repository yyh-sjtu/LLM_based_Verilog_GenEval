
module TopModule(
    input  wire        clk,
    input  wire        reset,
    output reg  [3:0]  ena,    // Enable for the higher 3 BCD digits
    output reg [15:0]   q       // BCD counter output (4 digits)
);

    // BCD counter with 4 decimal digits
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all digits
            q <= 16'b0;
            ena <= 4'b0;
        end else begin
            // Check for overflow and increment the BCD digits
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000;             // Reset ones digit
                ena[0] <= 1'b1;                 // Enable the tens digit increment

                // Increment tens digit
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000;         // Reset tens digit
                    ena[1] <= 1'b1;             // Enable the hundreds digit increment

                    // Increment hundreds digit
                    if (q[11:8] == 4'b1001) begin
                        q[11:8] <= 4'b0000;    // Reset hundreds digit
                        ena[2] <= 1'b1;         // Enable the thousands digit increment

                        // Increment thousands digit
                        if (q[15:12] == 4'b1001) begin
                            q[15:12] <= 4'b0000; // Reset thousands digit
                            ena[3] <= 1'b0;      // Do not enable increment for thousands
                        end else begin
                            q[15:12] <= q[15:12] + 1'b1; // Increment thousands digit
                            ena[3] <= 1'b0;      // No need to enable for thousands after increment
                        end
                    end else begin
                        q[11:8] <= q[11:8] + 1'b1; // Increment hundreds digit
                        ena[2] <= 1'b0;             // No need to enable for hundreds after increment
                    end
                end else begin
                    q[7:4] <= q[7:4] + 1'b1;       // Increment tens digit
                    ena[1] <= 1'b0;                 // No need to enable for tens after increment
                end
            end else begin
                q[3:0] <= q[3:0] + 1'b1;           // Increment ones digit
                ena[0] <= 1'b0;                     // No need to enable for ones after increment
            end
        end
    end
endmodule
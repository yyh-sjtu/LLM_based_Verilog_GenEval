
module TopModule (
    input  wire clk,
    input  wire reset,
    output reg  [3:0] ena,
    output reg  [15:0] q
);

    // Initialize the BCD counter
    initial begin
        q = 16'b0; // Initialize the output to all zeros
        ena = 4'b0000; // Initialize enable signals to zero
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'b0; // Reset the counter to zero
            ena <= 4'b0000; // Reset enable signals
        end
        else begin
            // Increment the least significant digit (ones place)
            if (q[3:0] == 4'b1001) begin
                q[3:0] <= 4'b0000; // Roll over to 0
                ena[0] <= 1'b1; // Enable carry to tens digit
            end
            else begin
                q[3:0] <= q[3:0] + 1'b1; // Increment ones digit
                ena[0] <= 1'b0; // Disable carry
            end

            // Increment the tens place if needed
            if (ena[0]) begin
                if (q[7:4] == 4'b1001) begin
                    q[7:4] <= 4'b0000; // Roll over to 0
                    ena[1] <= 1'b1; // Enable carry to hundreds digit
                end
                else begin
                    q[7:4] <= q[7:4] + 1'b1; // Increment tens digit
                    ena[1] <= 1'b0; // Disable carry
                end
            end

            // Increment the hundreds place if needed
            if (ena[1]) begin
                if (q[11:8] == 4'b1001) begin
                    q[11:8] <= 4'b0000; // Roll over to 0
                    ena[2] <= 1'b1; // Enable carry to thousands digit
                end
                else begin
                    q[11:8] <= q[11:8] + 1'b1; // Increment hundreds digit
                    ena[2] <= 1'b0; // Disable carry
                end
            end

            // Increment the thousands place if needed
            if (ena[2]) begin
                if (q[15:12] == 4'b1001) begin
                    q[15:12] <= 4'b0000; // Roll over to 0
                    ena[3] <= 1'b1; // Optional: can indicate overflow here
                end
                else begin
                    q[15:12] <= q[15:12] + 1'b1; // Increment thousands digit
                    ena[3] <= 1'b0; // Disable carry
                end
            end
            
        end
    end
endmodule
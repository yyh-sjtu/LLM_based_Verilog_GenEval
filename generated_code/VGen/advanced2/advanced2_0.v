module for a decade counter that counts from 0 through 9
// using a clock signal, slow enable signal, and reset signal.

module count_slow (
    input clk,         // Clock signal
    input slowena,     // Slow enable signal
    input reset,       // Reset signal
    output reg [3:0] q // Output representing the count value
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset the count value to 0
        end else begin
            if (slowena) begin
                // Increment the count value if slow enable is high
                if (q == 4'b1001) begin
                    q <= 4'b0000; // Reset the count value to 0 when reaching 9
                end else begin
                    q <= q + 1; // Increment the count value by 1
                end
            end
        end
    end

endmodule


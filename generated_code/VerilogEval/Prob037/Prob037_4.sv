
module TopModule (
    input wire clk,
    input wire reset,
    output reg [9:0] q
);

    // Counter's maximum value
    localparam MAX_COUNT = 10'd999;

    // Synchronous reset and counting behavior
    always @(posedge clk) begin
        if (reset) begin
            // Reset the counter to 0 when reset is high
            q <= 10'd0;
        end else begin
            // Increment the counter on every clock cycle
            if (q < MAX_COUNT) begin
                q <= q + 10'd1;
            end else begin
                // Reset back to 0 after reaching 999
                q <= 10'd0;
            end
        end
    end

endmodule
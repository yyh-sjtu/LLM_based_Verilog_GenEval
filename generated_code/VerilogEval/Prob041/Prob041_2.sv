
module TopModule (
    input  wire       clk,    // Clock input
    input  wire       reset,  // Reset input
    input  wire [7:0] d,      // 8-bit data input
    output reg  [7:0] q       // 8-bit data output
);

    // 8 D Flip-Flops
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000;  // Reset output to zero
        end else begin
            q <= d;            // Capture data on clock edge
        end
    end

endmodule

module TopModule (
    input  clk,
    input  reset,
    input  [7:0] d,
    output reg [7:0] q
);

// D Flip-Flops with synchronous reset
always @(posedge clk) begin
    if (reset) begin
        q <= 8'b0; // Set output to zero on reset
    end else begin
        q <= d; // Capture input d on rising edge of clk
    end
end

endmodule
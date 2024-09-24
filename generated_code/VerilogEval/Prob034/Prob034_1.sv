
module TopModule (
    input  clk,
    input  [7:0] d,
    output reg [7:0] q
);

// D Flip-Flops
always @(posedge clk) begin
    q <= d; // Capture the input 'd' on the positive edge of 'clk'
end

endmodule

module TopModule (
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    // 8 D flip-flops
    always @(posedge clk) begin
        q <= d; // On the positive edge of the clock, output q will follow input d
    end

endmodule
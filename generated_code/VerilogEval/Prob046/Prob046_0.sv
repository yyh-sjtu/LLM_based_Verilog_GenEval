
module TopModule (
    input clk,
    input reset,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] d_reg;

always @(negedge clk or posedge reset) begin
    if (reset) begin
        d_reg <= 8'b00110100; // reset to 0x34
    end else begin
        d_reg <= d;
    end
end

always @(negedge clk) begin
    q <= d_reg;
end

endmodule
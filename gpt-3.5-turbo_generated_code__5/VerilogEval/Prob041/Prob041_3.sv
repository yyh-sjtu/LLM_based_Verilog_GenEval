
module TopModule (
    input clk,
    input reset,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] d_reg;

always @(posedge clk) begin
    if (reset) begin
        q <= 8'b0;
    end else begin
        q <= d_reg;
    end
end

always @(posedge clk) begin
    if (reset) begin
        d_reg <= 8'b0;
    end else begin
        d_reg <= d;
    end
end

endmodule
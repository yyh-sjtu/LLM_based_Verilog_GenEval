
module TopModule (
    input clk,
    input areset,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] d_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        d_reg <= 8'b00000000;
    end else begin
        d_reg <= d;
    end
end

always @(posedge clk) begin
    if (!areset) begin
        q <= d_reg;
    end
end

endmodule
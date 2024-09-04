
module TopModule (
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_reg;

always @(posedge clk) begin
    q_reg <= d;
end

assign q = q_reg;

endmodule
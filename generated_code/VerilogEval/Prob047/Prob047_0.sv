
module TopModule (
    input clk,
    input areset,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_reg;

always @(posedge clk or posedge areset)
begin
    if (areset)
        q_reg <= 8'b00000000;
    else
        q_reg <= d;
end

assign q = q_reg;

endmodule
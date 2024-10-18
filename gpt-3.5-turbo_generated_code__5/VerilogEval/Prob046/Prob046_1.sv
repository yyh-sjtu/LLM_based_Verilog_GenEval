
module TopModule (
    input clk,
    input reset,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] q_reg; // Internal register to hold the output values

always @(negedge clk or posedge reset)
begin
    if (reset) begin
        q_reg <= 8'b00110100; // Reset to 0x34
    end else begin
        q_reg <= d;
    end
end

assign q = q_reg;

endmodule
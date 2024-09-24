
module pe(
    input clk,
    input rst,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] c
);

always @(posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
        c <= 32'b0; // Reset the accumulator register
    end 
    else begin
        c <= c + (a * b); // Accumulate the product of input operands
    end
end

endmodule
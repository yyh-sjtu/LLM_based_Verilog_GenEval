
module TopModule (
    input clk,
    input a,
    input b,
    output reg out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

assign out_assign = a ^ b;

always @* begin
    out_always_comb = a ^ b;
end

reg xor_output_ff;
always @(posedge clk) begin
    xor_output_ff <= a ^ b;
end
always @(posedge clk) begin
    out_always_ff <= xor_output_ff;
end

endmodule
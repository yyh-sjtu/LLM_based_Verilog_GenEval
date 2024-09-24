
module TopModule (
    input clk,
    input x,
    output reg z
);

reg xor_in, and_in, or_in;
reg xor_ff, and_ff, or_ff;

always @(posedge clk) begin
    xor_in <= x ^ xor_ff;
    and_in <= x & ~and_ff;
    or_in <= x | ~or_ff;
    
    xor_ff <= xor_in;
    and_ff <= and_in;
    or_ff <= or_in;
    
    z <= ~(xor_ff & and_ff & or_ff);
end

endmodule
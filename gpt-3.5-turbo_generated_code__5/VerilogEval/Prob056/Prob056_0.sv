
module TopModule (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j & ~k)
        Q <= 1;         // J=1, K=0
    else if (~j & k)
        Q <= 0;         // J=0, K=1
    else if (j & k)
        Q <= ~Q;        // J=1, K=1
    // No change if J=0, K=0
end

endmodule
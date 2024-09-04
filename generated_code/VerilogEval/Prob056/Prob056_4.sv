
module TopModule (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk) begin
    if (j & ~k)
        Q <= 1;
    else if (~j & k)
        Q <= 0;
    else if (j & k)
        Q <= ~Q;
end

endmodule
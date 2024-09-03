
module mux(
    input [4:0] a, b,
    input sel,
    output reg [4:0] out
);

always @(a, b, sel)
begin
    if(sel == 1'b0)
        out = a;
    else
        out = b;
end

endmodule
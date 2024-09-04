module mux(
    input [4:0] a,
    input [4:0] b,
    input sel,
    output reg [4:0] out
);

always @* begin
    if(sel)
        out = b;
    else
        out = a;
end

endmodule

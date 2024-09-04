
module TopModule(
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always @* begin
    min = a;
    
    if (b < min)
        min = b;
    if (c < min)
        min = c;
    if (d < min)
        min = d;
end

endmodule
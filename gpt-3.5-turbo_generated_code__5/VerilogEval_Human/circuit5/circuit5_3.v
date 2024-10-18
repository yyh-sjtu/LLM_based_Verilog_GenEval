module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @* begin
    if (a == 4'b0000 && b == 4'b0000 && c == 4'b0000 && d == 4'b0000 && e == 4'b0000)
        q = 4'b0000;
    else if (a == b && b == c && c == d && d == e)
        q = b;
    else if (a > b && a > c && a > d && a > e)
        q = a;
    else if (b > a && b > c && b > d && b > e)
        q = b;
    else if (c > a && c > b && c > d && c > e)
        q = c;
    else if (d > a && d > b && d > c && d > e)
        q = d;
    else if (e > a && e > b && e > c && e > d)
        q = e;
    else
        q = 4'b1111;
end

endmodule


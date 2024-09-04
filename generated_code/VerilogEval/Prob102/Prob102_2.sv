module TopModule (
    input a,
    input b,
    input c,
    input d,
    output reg q
);

always @* begin
    if((b || c) || (a && d))
        q = 1;
    else
        q = 0;
end

endmodule


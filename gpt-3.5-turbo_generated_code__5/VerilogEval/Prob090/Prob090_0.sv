
module TopModule(
    input a,
    input b,
    output reg q
);

always @(*) begin
    if(a & b)
        q = 1;
    else
        q = 0;
end

endmodule

module TopModule(
    input a,
    input b,
    input c,
    input d,
    output reg q
);

always @(*) begin
    if(a == 0 && b == 0 && c == 0) begin
        q = 1;
    end else if(a == 0 && b == 0 && c == 1 && d == 0) begin
        q = 0;
    end else begin
        q = ~(a & b & c);
    end
end

endmodule
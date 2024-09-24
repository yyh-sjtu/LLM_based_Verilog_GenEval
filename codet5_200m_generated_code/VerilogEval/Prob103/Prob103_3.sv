module TopModule (
    input a,
    input b,
    input c,
    input d,
    output q
);
    reg [3:0] x;
    always @(a or b or c or d) begin
        x = a ^ b;
    end
    assign q = x;
endmodule


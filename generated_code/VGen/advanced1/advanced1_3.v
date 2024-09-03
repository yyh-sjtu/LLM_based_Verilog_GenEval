module signed_adder(
    input [7:0] a, 
    input [7:0] b, 
    output reg [7:0] s, 
    output reg overflow
);

    always @(*) begin
        s = a + b;
        overflow = ((a[7] == b[7]) && (s[7] != a[7])) ? 1 : 0;
    end

endmodule


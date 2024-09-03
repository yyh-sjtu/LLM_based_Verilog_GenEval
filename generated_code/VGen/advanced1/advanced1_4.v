module signed_adder(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] sum;
    
    always @(*) begin
        sum = a + b;
    end
    
    assign s = sum;
    
    assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);
    
endmodule


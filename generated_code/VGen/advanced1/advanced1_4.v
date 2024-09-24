module signed_adder (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

reg [8:0] sum;

always @* begin
    sum = a + b;
    if(sum[8] != sum[7])      // Check if the sign bits are different
        overflow = 1;
    else
        overflow = 0;
    
    s = sum[7:0];             // Take the lower 8 bits as output
end

endmodule


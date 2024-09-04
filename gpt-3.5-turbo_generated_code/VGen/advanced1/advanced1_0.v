module signed_adder(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] sum;
    
    always @* begin
        sum = a + b; // perform the addition
        
        // capture the signed overflow
        if (((a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7])) == 1)
            overflow = 1;
        else
            overflow = 0;
        
        s = sum; // assign the result to output
    end

endmodule


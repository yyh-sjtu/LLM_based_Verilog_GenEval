module signed_adder(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;

    always @* begin
        sum = a + b;
        s = sum[7:0];
        
        if(sum[8] != sum[7]) begin
            overflow = 1;
        end else begin
            overflow = 0;
        end
    end

endmodule


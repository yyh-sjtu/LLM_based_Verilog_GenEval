module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output reg [15:0] y,
    output reg Co
);

reg [6:0] carry;
reg [7:0] sum;

always @* begin
    sum[0] = a[0] ^ b[0] ^ Cin;
    carry[0] = (a[0] & b[0]) | (a[0] & Cin) | (b[0] & Cin);

    // 8-bit carry ripple adder
    for (i = 1; i < 8; i = i + 1) begin
        sum[i] = a[i] ^ b[i] ^ carry[i-1];
        carry[i] = (a[i] & b[i]) | (a[i] & carry[i-1]) | (b[i] & carry[i-1]);
    end

    y = {sum, sum[7] ^ carry[6]};

    Co = carry[7];
end

endmodule


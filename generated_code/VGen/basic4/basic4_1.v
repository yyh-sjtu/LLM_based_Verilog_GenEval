
module full_adder_16bit(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
);

    wire [15:0] carry;
    
    assign {carry[0], sum[0]} = a[0] + b[0] + cin;
    assign {carry[1], sum[1]} = a[1] + b[1] + carry[0];
    assign {carry[2], sum[2]} = a[2] + b[2] + carry[1];
    assign {carry[3], sum[3]} = a[3] + b[3] + carry[2];
    assign {carry[4], sum[4]} = a[4] + b[4] + carry[3];
    assign {carry[5], sum[5]} = a[5] + b[5] + carry[4];
    assign {carry[6], sum[6]} = a[6] + b[6] + carry[5];
    assign {carry[7], sum[7]} = a[7] + b[7] + carry[6];
    assign {carry[8], sum[8]} = a[8] + b[8] + carry[7];
    assign {carry[9], sum[9]} = a[9] + b[9] + carry[8];
    assign {carry[10], sum[10]} = a[10] + b[10] + carry[9];
    assign {carry[11], sum[11]} = a[11] + b[11] + carry[10];
    assign {carry[12], sum[12]} = a[12] + b[12] + carry[11];
    assign {carry[13], sum[13]} = a[13] + b[13] + carry[12];
    assign {carry[14], sum[14]} = a[14] + b[14] + carry[13];
    assign {carry[15], sum[15]} = a[15] + b[15] + carry[14];
    
    assign cout = carry[15];
    
endmodule
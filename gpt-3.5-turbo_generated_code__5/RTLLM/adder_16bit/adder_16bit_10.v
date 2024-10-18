module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0]  sum_8bit;
wire       carry_7to0;
wire       carry_8;

// Instantiate 8-bit adders
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin: adder_instance
        full_adder_8bit inst (
            .a(a[i*2 +: 2]),
            .b(b[i*2 +: 2]),
            .Cin(carry_7to0),
            .sum(sum_8bit[i]),
            .Co(carry_8)
        );
    end
endgenerate

assign y = {sum_8bit, sum_8bit[6:0]};
assign Co = carry_8;

endmodule

module full_adder_8bit (
    input[1:0] a,
    input[1:0] b,
    input Cin,
    output[1:0] sum,
    output Co
);

wire P0, G0, P1, G1, P2, G2;
wire b0, b1, b2, b3, b4, b5;
wire c0, c1, c2, c3, c4;

assign b0 = a[0] & b[0];
assign b1 = a[0] | b[0];
assign b2 = a[1] & b[1];
assign b3 = a[1] | b[1];
assign b4 = b0 & Cin;
assign b5 = b2 & Cin;

assign P0 = a[0] ^ b[0];
assign G0 = b1;

assign P1 = a[1] ^ b[1];
assign G1 = b3;

assign P2 = sum[0] ^ Cin;
assign G2 = b4 | b5;

assign {sum, Co} = P0 + G0 + P1 + G1 + P2 + G2;

endmodule


module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] carry;
wire [7:0] sum;

// Instantiating eight 8-bit full adders
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin: FA_INST
        full_adder FA(
            .a(a[i*2 +: 2]),
            .b(b[i*2 +: 2]),
            .Cin(carry[i]),
            .sum(sum[i]),
            .Cout(carry[i+1])
        );
    end
endgenerate

assign y = {sum[6:0], sum[7]};
assign Co = carry[7];

endmodule

module full_adder (
    input [1:0] a,
    input [1:0] b,
    input Cin,
    output [1:0] sum,
    output Cout
);

assign sum = a + b + Cin;
assign Cout = (a[1] & b[1]) | (a[1] & Cin) | (b[1] & Cin);

endmodule


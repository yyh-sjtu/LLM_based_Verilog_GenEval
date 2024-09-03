
module full_adder(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [16:0] sum,
    output cout
);

wire [15:0] s;
wire c;

genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin : adder_loop
        full_adder_1bit fa(
            .a(a[i]),
            .b(b[i]),
            .cin(c),
            .sum(s[i]),
            .cout(c)
        );
    end
endgenerate

assign sum = {c, s};
assign cout = c;

endmodule

module full_adder_1bit(
    input a, b, cin,
    output sum, cout
);

assign {cout, sum} = a + b + cin;

endmodule
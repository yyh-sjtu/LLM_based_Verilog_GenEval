
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output reg [7:0] sum,
    output reg cout
);

reg [7:0] carry;

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : adder_loop
        full_adder adder_instance (
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i]),
            .sum(sum[i]),
            .cout(carry[i+1])
        );
    end
endgenerate

assign cout = carry[8];

endmodule

module full_adder (
    input a,
    input b,
    input cin,
    output reg sum,
    output reg cout
);

assign {cout, sum} = a + b + cin;

endmodule
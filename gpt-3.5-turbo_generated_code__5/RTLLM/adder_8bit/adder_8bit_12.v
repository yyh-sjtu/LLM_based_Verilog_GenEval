
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output reg [7:0] sum,
    output reg cout
);

reg [7:0] carry;
wire [7:0] sum_wire;

// Instantiate 8 full adders for the 8-bit addition
genvar i;
generate
    for (i = 0; i < 8; i=i+1) begin: full_adder_instance
        full_adder fa (
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i]),
            .sum(sum_wire[i]),
            .cout(carry[i+1])
        );
    end
endgenerate

// Connect the carry chain and sum bits
assign carry[0] = cin;
assign sum = sum_wire;
assign cout = carry[7];

endmodule

module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign {cout, sum} = a + b + cin;

endmodule
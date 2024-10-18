
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
);

wire [7:0] carry;
wire [7:0] sum_intermediate;

// First bit-level adder
full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum_intermediate[0]), .cout(carry[0]));

// Intermediate bit-level adders
genvar i;
generate
    for (i = 1; i < 8; i = i + 1) begin : adder_loop
        full_adder fa (.a(a[i]), .b(b[i]), .cin(carry[i-1]), .sum(sum_intermediate[i]), .cout(carry[i]));
    end
endgenerate

// Last bit-level adder
assign sum[7:0] = sum_intermediate[7:0];
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
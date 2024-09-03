
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
);

wire [7:0] carry;
wire [7:0] sum_intermediate;

// Bit-level full adder instances
genvar i;
generate
    for (i = 0; i < 8; i=i+1) begin : adder_loop
        full_adder adder_inst (
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i]),
            .sum(sum_intermediate[i]),
            .cout(carry[i+1])
        );
    end
endgenerate

assign sum[0] = sum_intermediate[0];
assign sum = sum_intermediate;
assign cout = carry[8];

endmodule

module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (cin & (a ^ b));

endmodule
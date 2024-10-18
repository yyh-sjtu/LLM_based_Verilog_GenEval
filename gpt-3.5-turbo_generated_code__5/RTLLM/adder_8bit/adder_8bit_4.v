module adder_8bit(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
);

wire [7:0] carry;
wire [7:0] sum_temp;

// First bit-level adder
full_adder FA0(a[0], b[0], cin, sum_temp[0], carry[0]);

// Intermediate bit-level adders
genvar i;
generate
    for (i = 1; i < 8; i=i+1) begin : adder_loop
        full_adder FA(a[i], b[i], carry[i-1], sum_temp[i], carry[i]);
    end
endgenerate

// Last bit-level adder with carry-out
full_adder FA_last(a[7], b[7], carry[6], sum[7], cout);

assign sum = sum_temp;
assign cout = carry[7];

endmodule


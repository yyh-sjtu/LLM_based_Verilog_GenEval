
module adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input cin,
    output reg [7:0] sum,
    output reg cout
);

reg c;

// First Full Adder
full_adder FA0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c));

// Intermediate Full Adders
genvar i;
generate
    for (i = 1; i < 7; i = i + 1) begin : FA_gen
        full_adder FA (.a(a[i]), .b(b[i]), .cin(c), .sum(sum[i]), .cout(c));
    end
endgenerate

// Last Full Adder
full_adder FA7 (.a(a[7]), .b(b[7]), .cin(c), .sum(sum[7]), .cout(cout);

endmodule

module full_adder (
    input a,
    input b,
    input cin,
    output reg sum,
    output reg cout
);

always @* begin
    sum = a ^ b ^ cin;
    cout = (a & b) | (a & cin) | (b & cin);
end

endmodule
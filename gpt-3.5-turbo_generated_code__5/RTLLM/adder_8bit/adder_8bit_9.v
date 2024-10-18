module adder_8bit(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output reg [7:0] sum,
    output reg cout
);

reg carry;
reg [7:0] c;

// First bit-level adder
full_adder fa0(a[0], b[0], cin, sum[0], c[0]);

// Subsequent bit-level adders
genvar i;
generate
    for (i = 1; i < 8; i = i + 1) begin
        full_adder fa(a[i], b[i], c[i-1], sum[i], c[i]);
    end
endgenerate

assign cout = c[7];

endmodule

module full_adder(
    input a, 
    input b, 
    input cin, 
    output reg sum, 
    output reg carry
);

assign {carry, sum} = a + b + cin;

endmodule


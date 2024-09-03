module full_adder(
    input [15:0] a, b, cin,
    output [15:0] sum, cout
);

wire [15:0] c; // Carry vector
xor #(16) x1 (c[0], a[0], b[0]);
xor #(16) x2 (sum[0], c[0], cin);

for (int i = 1; i < 16; i = i + 1) begin
    xor #(16) x3 (c[i], a[i], b[i]);
    xor #(16) x4 (sum[i], c[i], c[i-1]);
end

assign cout = c[15];

endmodule

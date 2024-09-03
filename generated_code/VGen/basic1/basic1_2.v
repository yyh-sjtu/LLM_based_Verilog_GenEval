module full_adder_16bit(
    input [15:0] a, b,
    input cin,
    output [15:0] sum,
    output cout
);

wire [15:0] carry;
genvar i;

assign carry[0] = cin;

generate
    for (i = 0; i < 15; i = i + 1) begin
        assign carry[i+1] = (a[i] & b[i]) | (a[i] & carry[i]) | (b[i] & carry[i]);
        assign sum[i] = a[i] ^ b[i] ^ carry[i];
    end
endgenerate

assign sum[15] = a[15] ^ b[15] ^ carry[15];
assign cout = (a[15] & b[15]) | (a[15] & carry[15]) | (b[15] & carry[15]);

endmodule


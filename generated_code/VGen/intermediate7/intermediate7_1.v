module FullAdder (
    input wire [15:0] A,
    input wire [15:0] B,
    input wire Cin,
    output wire [15:0] Sum,
    output wire Cout
);

genvar i;
generate
for (i = 0; i < 16; i = i + 1) begin : full_adder_loop
    assign Sum[i] = A[i] ^ B[i] ^ Cin;
    assign Cin = (A[i] & B[i]) | (A[i] & Cin) | (B[i] & Cin);
end
endgenerate

assign Cout = Cin;

endmodule


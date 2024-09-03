module FullAdder16 (
    input [15:0] A,
    input [15:0] B,
    input C_in,
    output [15:0] Sum,
    output C_out
);

wire [15:0] A_xor_B;
wire [15:0] A_and_B;
wire [15:0] xor_result;

assign A_xor_B = A ^ B;
assign A_and_B = A & B;
assign xor_result = A_xor_B ^ C_in;

assign Sum = xor_result;
assign C_out = (A_and_B | (A_xor_B & C_in));

endmodule


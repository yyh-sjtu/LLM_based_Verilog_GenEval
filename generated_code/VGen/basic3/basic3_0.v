module full_adder_16bit(
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output reg [15:0] Sum,
    output Cout
);

// Internal signals
reg [15:0] temp_Sum;

always @(*)
begin
    temp_Sum[0] = A[0] ^ B[0] ^ Cin;
    temp_Sum[1] = A[1] ^ B[1] ^ (A[0] & B[0]) ^ (A[0] & Cin) ^ (B[0] & Cin);
    temp_Sum[2] = A[2] ^ B[2] ^ (A[1] & B[1]) ^ (A[1] & A[0] & B[0]) ^ (A[1] & A[0] & Cin) ^ (A[0] & B[0] & Cin);
    // Continue this pattern until reaching 15th bit

    Sum = temp_Sum;
    Cout = (A[15] & B[15]) | (A[15] & Cin) | (B[15] & Cin);
end

endmodule

module priority_encoder( 
    input [2:0] in,
    output reg [1:0] pos
);

always @(*)
begin
    case(in)
        3'b000: pos = 2'b00;
        3'b001: pos = 2'b01;
        3'b010: pos = 2'b01;
        3'b011: pos = 2'b10;
        // Continue this pattern until reaching 3'b111
    endcase
end

endmodule


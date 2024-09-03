module signed_adder(
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] temp_s;
    reg overflow;

    assign s = temp_s;
    assign overflow = temp_s[7] ^ s[7] ^ a[7] ^ b[7];

    always @(*) begin
        temp_s = a + b;
    end

endmodule


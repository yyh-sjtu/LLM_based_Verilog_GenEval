module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [7:0] carry;
wire [7:0] sum;

// Instantiating 8-bit adder 16 times and connecting them to form a 16-bit adder
genvar i;
generate
    for (i = 0; i < 16; i = i+1) begin : adder_inst
        full_adder_8bit adder (
            .a(a[i*8 +: 8]),
            .b(b[i*8 +: 8]),
            .Cin(Cin),
            .y(y[i*8 +: 8]),
            .Co(carry[i])
        );
    end
endgenerate

// Carry-out of the last stage is taken as the final carry-out
assign Co = carry[7];

endmodule

module full_adder_8bit (
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output reg [7:0] y,
    output carry
);

// Instantiating 1-bit full adder 8 times and connecting them to form an 8-bit adder
genvar j;
generate
    for (j = 0; j < 8; j = j+1) begin : fa_inst
        bit_full_adder adder_bit (
            .a(a[j]),
            .b(b[j]),
            .Cin(Cin),
            .y(y[j]),
            .Co(carry[j])
        );
    end
endgenerate

endmodule

module bit_full_adder (
    input a,
    input b,
    input Cin,
    output reg y,
    output carry
);

assign {carry, y} = a + b + Cin;

endmodule


module full_adder_8bit (
    input a,
    input b,
    input Cin,
    output y,
    output Co
);

assign {Co, y} = a + b + Cin;

endmodule

module adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input Cin,
    output [15:0] y,
    output Co
);

wire [15:0] Co_intermediate;
wire [15:0] y_intermediate;

full_adder_8bit fa1 (.a(a[0]), .b(b[0]), .Cin(Cin), .y(y_intermediate[0]), .Co(Co_intermediate[0]));
full_adder_8bit fa2 (.a(a[1]), .b(b[1]), .Cin(Co_intermediate[0]), .y(y_intermediate[1]), .Co(Co_intermediate[1]));
// Continue instantiating full adders for the remaining bits

assign Co = Co_intermediate[15];
assign y = y_intermediate;

endmodule


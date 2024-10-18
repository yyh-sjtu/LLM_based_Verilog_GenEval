
module TopModule(
    input  wire in1,
    input  wire in2,
    output wire out
);
    wire in2_inverted;

    assign in2_inverted = ~in2;

    assign out = in1 & in2_inverted;
endmodule
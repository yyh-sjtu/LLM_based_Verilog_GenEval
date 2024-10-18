
module TopModule (
    input in1,
    input in2,
    output out
);

    wire in2_bubble;
    assign in2_bubble = ~in2;

    assign out = in1 & in2_bubble;

endmodule
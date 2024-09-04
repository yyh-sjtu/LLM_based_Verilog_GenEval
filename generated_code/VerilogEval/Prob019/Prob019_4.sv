
module TopModule(
    input in1,
    input in2,
    output out
);

    wire n_in2; // inverted input in2

    assign n_in2 = ~in2;
    assign out = in1 & n_in2;

endmodule
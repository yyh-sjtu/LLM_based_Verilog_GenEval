module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Assign output q based on input values
    assign q = (a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d);

endmodule


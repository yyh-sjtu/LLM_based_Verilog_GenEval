
module TopModule (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire condition1, condition2, condition3;

    // Implement the conditions for generating a logic-1 output
    assign condition1 = ~(a^b) & c & d;
    assign condition2 = a & ~b & c & ~d;
    assign condition3 = a & b & ~c & ~d;

    // Determine the output out_sop in minimum sum-of-products form
    assign out_sop = condition1 | condition2 | condition3;

    // Determine the output out_pos in minimum product-of-sums form
    assign out_pos = condition1 & condition2 & condition3;

endmodule
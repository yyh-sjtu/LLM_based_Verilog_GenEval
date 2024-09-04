
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

    // Internal signal to hold the output value
    wire row1, row2, row3, row4;

    // Row values according to the Karnaugh map:
    // Row for cd = 00
    assign row1 = (c == 0 && d == 0) ? 1'bx :  // don't care, can choose to assign 0 or 1
                   (b == 0 && a == 0) ? 1'b0 :  // ab = 00 -> 0
                   (b == 0 && a == 1) ? 1'b1 :  // ab = 01 -> 1
                   (b == 1 && a == 0) ? 1'b1 :  // ab = 10 -> 1
                   (b == 1 && a == 1) ? 1'b1 :  // ab = 11 -> 1
                   1'bx; // Don't care output

    // Row for cd = 01
    assign row2 = (c == 0 && d == 1) ? 1'b0 :  // ab = 00 -> 0
                   (b == 0 && a == 1) ? 1'bx :  // ab = 01 -> don't care
                   (b == 1 && a == 0) ? 1'bx :  // ab = 10 -> don't care
                   (b == 1 && a == 1) ? 1'b0 :  // ab = 11 -> 0
                   1'b0; // input not in range

    // Row for cd = 11
    assign row3 = (c == 1 && d == 1) ? 1'b1 :  // ab = 00 -> 0
                   (b == 0 && a == 1) ? 1'b1 :  // ab = 01 -> 1
                   (b == 1 && a == 0) ? 1'b1 :  // ab = 10 -> 1
                   (b == 1 && a == 1) ? 1'b1 :  // ab = 11 -> 1
                   1'b0;

    // Row for cd = 10
    assign row4 = (c == 1 && d == 0) ? 1'b1 :  // ab = 00 -> 0
                   (b == 0 && a == 1) ? 1'b1 :  // ab = 01 -> 1
                   (b == 1 && a == 0) ? 1'b1 :  // ab = 10 -> 1
                   (b == 1 && a == 1) ? 1'b1 :  // ab = 11 -> 1
                   1'b0;

    // Combine all the outputs based on the four rows determined
    assign out = (c == 0 && d == 0) ? row1 :
                 (c == 0 && d == 1) ? row2 :
                 (c == 1 && d == 0) ? row4 :
                 (c == 1 && d == 1) ? row3 : 1'bx;

endmodule
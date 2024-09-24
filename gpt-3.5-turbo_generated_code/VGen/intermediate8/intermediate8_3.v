
module truthtable(
    input x3,
    input x2,
    input x1,
    output f
);

    assign f = (~x3 & ~x2 & ~x1) |         // 000
               (~x3 & ~x2 & x1) |          // 001
               (~x3 & x2 & x1) |           // 011
               (x3 & x2 & ~x1);             // 110

endmodule
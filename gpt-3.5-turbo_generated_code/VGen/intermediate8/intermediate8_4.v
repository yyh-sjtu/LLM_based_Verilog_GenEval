
module truthtable (
    input x3,
    input x2,
    input x1,
    output f
);
    assign f = (~x3 & ~x2 & ~x1) |   // m0
               (~x3 & ~x2 & x1)  |   // m1
               (~x3 & x2 & x1)   |   // m3
               (x3 & x2 & ~x1);       // m6
endmodule
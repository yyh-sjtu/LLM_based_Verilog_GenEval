module based on the given truth table

module truthtable(input x3, input x2, input x1, output f );
    assign f = ~((x3 & x2 & ~x1) | (~x3 & x2 & x1) | (~x3 & ~x2 & ~x1) | (x3 & ~x2 & x1));
endmodule



module truthtable(input x3, input x2, input x1, output f);
    // Declare the output wire
    wire f;

    // Generate the output f based on the truth table using logical expressions
    assign f = (~x3 & ~x2) |  // f = 1 when x3=0 and x2=0 (x1 can be 0 or 1)
               (~x3 & x1) |   // f = 1 when x3=0 and x2=1 and x1=1
               (x3 & ~x2 & x1) | // f = 1 when x3=1 and x2=1 and x1=0
               (x3 & x2 & ~x1);  // f = 1 when x3=1 and x2=0

endmodule
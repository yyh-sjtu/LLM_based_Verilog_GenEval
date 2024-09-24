module alu (
    input [31:0] a,
    input [31:0] b,
    input [5:0] aluc,
    output [31:0] r,
    output zero,
    output carry,
    output negative,
    output overflow,
    output flag
);
    assign r = a + b;
    assign zero = (aluc == 6'b0000)? 1'b1 : 1'b0;
    assign carry = (aluc == 6'b0001)? 1'b1 : 1'b0;
    assign negative = (aluc == 6'b0010)? 1'b1 : 1'b0;
    assign overflow = (aluc == 6'b0011)? 1'b1 : 1'b0;
    assign flag = (aluc == 6'b0012)? 1'b1 : 1'b0;
endmodule


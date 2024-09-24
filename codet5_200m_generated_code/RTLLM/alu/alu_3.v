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
    assign flag = aluc[5];
    assign zero = aluc[5] == 5'b0000;
    assign carry = aluc[5] == 5'b0001;
    assign negative = aluc[5] == 5'b0010;
    assign overflow = aluc[5] == 5'b0100;
endmodule


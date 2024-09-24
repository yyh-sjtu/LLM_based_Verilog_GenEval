module TopModule (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    assign out = (a & b & c & d & e);
endmodule


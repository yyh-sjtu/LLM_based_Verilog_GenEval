module TopModule (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    assign out[0] = a;
    assign out[1] = b;
    assign out[2] = c;
    assign out[3] = d;
    assign out[4] = e;
endmodule


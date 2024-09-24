module TopModule (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    assign out[0] = c;
    assign out[1] = d;
    assign out[2] = e;
    assign out[3] = c;
    assign out[4] = d;
    assign out[5] = e;
    assign out[6] = d;
    assign out[7] = e;
endmodule


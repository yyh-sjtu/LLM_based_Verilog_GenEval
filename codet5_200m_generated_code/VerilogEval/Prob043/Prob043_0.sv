module TopModule (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [24:0] c_d;
    wire [24:0] c_e;
    assign c_d = a & b;
    assign c_e = c & ~e;
    assign out[0] = c_d & c_e;
    assign out[1] = c_d & ~c_e;
    assign out[2] = c_d & c_e;
    assign out[3] = c_d & ~c_e;
    assign out[4] = c_d & ~c_e;
    assign out[5] = c_d & ~c_e;
    assign out[6] = c_d & ~c_e;
    assign out[7] = c_d & ~c_e;
    assign out[8] = c_d & ~c_e;
    assign out[9] = c_d & ~c_e;
    assign out[10] = c_d & ~c_e;
    assign out[11] = c_d & ~c_e;
    assign out[12] = c_d & ~c_e;
    assign out[13] = c_d & ~c_e;
    assign out[14] = c_d & ~c_e;
    assign out[15] = c_d & ~c_e;
    assign out[16] = c_d & ~c_e;
    assign out[17] = c_d & ~c_e;
    assign out[18] = c_d & ~c_e;
    assign out[19] = c_d & ~c_e;
    assign out[20] = c_d & ~c_e;
    assign out[21] = c_d & ~c_e;
    assign out[22] = c_d & ~c_e;
    assign out[23] = c_d & ~c_e;
    assign out[24] = c_d & c_e;
endmodule


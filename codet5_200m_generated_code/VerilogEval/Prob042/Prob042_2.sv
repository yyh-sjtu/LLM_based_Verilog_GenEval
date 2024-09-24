module TopModule (
    input [7:0] in,
    output [31:0] out
);
    assign out = {in[7], in[6:1]};
endmodule


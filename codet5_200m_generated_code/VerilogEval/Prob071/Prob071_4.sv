module TopModule (
    input [7:0] in,
    output [2:0] pos
);
    assign pos = {in[7:0], 1'b1};
endmodule


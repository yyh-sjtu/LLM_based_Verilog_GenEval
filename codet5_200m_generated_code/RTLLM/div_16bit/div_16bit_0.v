module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output [15:0] result,
    output [15:0] odd
);
    assign result = A[15:8] - B[7:0];
    assign odd = A[15:8] - B[7:0];
endmodule


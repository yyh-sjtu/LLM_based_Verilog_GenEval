module div_16bit (
    input [15:0] A,
    input [7:0] B,
    output [15:0] result,
    output [15:0] odd
);
    reg [15:0] dividend;
    reg [7:0] divisor;
    assign result = dividend[15:8];
    assign odd = dividend[7:0];
    always @(*) begin
        if (A[15] > divisor[15]) begin
            dividend = A[15:8];
            divisor = B[7:0];
        end
        else begin
            dividend = A;
            divisor = B[7:0];
        end
    end
endmodule


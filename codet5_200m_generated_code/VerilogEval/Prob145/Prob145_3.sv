module TopModule (
    input clock,
    input a,
    output p,
    output q
);
    reg [31:0] A;
    always @(posedge clock) begin
        A <= a;
    end
    assign p = A[31];
    assign q = A[0];
endmodule


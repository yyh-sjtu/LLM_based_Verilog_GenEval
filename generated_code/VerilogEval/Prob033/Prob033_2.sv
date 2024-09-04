
module TopModule(
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

always @(*) begin
    {overflow, s} = a + b;
end

endmodule
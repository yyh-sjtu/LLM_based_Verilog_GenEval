
module full_adder_16bit(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire cin,
    output reg [15:0] sum,
    output reg cout
);

always @(*) begin
    {cout, sum} = a + b + cin;
end

endmodule
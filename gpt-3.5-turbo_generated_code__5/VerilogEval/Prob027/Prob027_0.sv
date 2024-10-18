
module TopModule (
    input a,
    input b,
    input cin,
    output reg cout,
    output reg sum
);

always @ (*) begin
    {cout, sum} = a + b + cin;
end

endmodule

module TopModule (
    input [2:0] a,
    input [2:0] b,
    output reg [2:0] out_or_bitwise,
    output reg out_or_logical,
    output reg [5:0] out_not
);

// Bitwise OR of input vectors a and b
always @* begin
    out_or_bitwise = a | b;
end

// Logical OR of input vectors a and b
always @* begin
    out_or_logical = |{a, b};
end

// Inverse (NOT) of input vectors a and b
always @* begin
    out_not[5:3] = ~b;
    out_not[2:0] = ~a;
end

endmodule
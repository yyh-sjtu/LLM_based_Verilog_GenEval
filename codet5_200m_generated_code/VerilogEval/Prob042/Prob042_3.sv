module TopModule (
    input [7:0] in,
    output [31:0] out
);
    wire [31:0] tmp;
    assign tmp = in;
    assign out = tmp;
endmodule



module TopModule (
    input [99:0] in,
    output [99:0] out
);

    assign out = {in[99:0]}; // Reverse the bit ordering of the input

endmodule
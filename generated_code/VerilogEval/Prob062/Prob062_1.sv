
module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out // Changed from single bit to 8 bits
);

    assign out = (sel) ? b : a; // Corrected the output assignment to choose whole buses

endmodule
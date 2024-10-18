
module TopModule(
    input [2:0] a,
    input [2:0] b,
    output reg [2:0] out_or_bitwise,
    output reg out_or_logical,
    output reg [5:0] out_not
);

    always @* begin
        // Compute bitwise OR of vectors a and b
        out_or_bitwise = a | b;

        // Compute logical OR of vectors a and b
        out_or_logical = (a | b) != 3'b000;

        // Inverse (NOT) of vector a assigned to lower half of out_not
        out_not[2:0] = ~a;

        // Inverse (NOT) of vector b assigned to upper half of out_not
        out_not[5:3] = ~b;
    end

endmodule
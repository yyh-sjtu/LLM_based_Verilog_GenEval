
module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire out
);

    assign out = (a == 1'b0 && b == 1'b0) && (c == 1'b0 || c == 1'b1 && d == 1'b0)
               || (a == 1'b0 && b == 1'b1 && c == 1'b0 && d == 1'b1)
               || (a == 1'b0 && b == 1'b1 && c == 1'b0 && d == 1'b0)
               || (a == 1'b1 && b == 1'b0 && c == 1'b0)
               || (a == 1'b1 && b == 1'b0 && c == 1'b1);
        
endmodule
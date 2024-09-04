
module TopModule (
    input  [3:0] x, // 4-bit input
    output f       // 1-bit output
);

assign f = ( (x == 4'b1100) ||  // x[3]x[4] = 11, x[1]x[2] = 00
             (x == 4'b1101) ||  // x[3]x[4] = 11, x[1]x[2] = 01
             (x == 4'b1000) ||  // x[3]x[4] = 10, x[1]x[2] = 00
             (x == 4'b1001) ||  // x[3]x[4] = 10, x[1]x[2] = 01
             (x == 4'b0110)    // x[3]x[4] = 01, x[1]x[2] = 10
           ) ? 1'b1 : 1'b0;     // Output f is high for the above conditions

endmodule

module TopModule (
    input  [3:0] x, // 4-bit input
    output       f   // 1-bit output
);
    
    assign f = ( (x == 4'b0110) || // minterm for (0, 1, 1, 0)
                 (x == 4'b0111) || // minterm for (0, 1, 1, 1)
                 (x == 4'b1100) || // minterm for (1, 1, 0, 0)
                 (x == 4'b1101)    // minterm for (1, 1, 0, 1)
               );

endmodule
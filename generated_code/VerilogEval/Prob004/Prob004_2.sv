
module TopModule (
    input  [31:0] in,  // 32-bit input
    output [31:0] out  // 32-bit output
);
    
    // Reverse byte order
    assign out = {
        in[7:0],   // Byte 0
        in[15:8],  // Byte 1
        in[23:16], // Byte 2
        in[31:24]  // Byte 3
    };

endmodule

module TopModule (
    input [3:0] a,  // 4-bit input
    input [3:0] b,  // 4-bit input
    input [3:0] c,  // 4-bit input
    input [3:0] d,  // 4-bit input
    input [3:0] e,  // 4-bit input
    output reg [3:0] q  // 4-bit output
);
    
    always @* begin
        case (c) // Combinational logic based on value of c
            4'd0: q = b;
            4'd1: q = e;
            4'd2: q = a;
            4'd3: q = d;
            default: q = e; // For c >= 4
        endcase
    end
    
endmodule
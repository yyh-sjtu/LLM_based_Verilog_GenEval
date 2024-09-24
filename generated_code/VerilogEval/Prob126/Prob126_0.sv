
module TopModule (
    input [2:0] a, // 3-bit input
    output reg [15:0] q // 16-bit output
);

    always @* begin
        case (a)
            3'b000: q = 16'h04D0; // 1232 in hexadecimal
            3'b001: q = 16'h0AE0; // aee0 in hexadecimal
            3'b010: q = 16'h27D4; // 27d4 in hexadecimal
            3'b011: q = 16'h5A0E; // 5a0e in hexadecimal
            3'b100: q = 16'h2066; // 2066 in hexadecimal
            3'b101: q = 16'h64CE; // 64ce in hexadecimal
            3'b110: q = 16'hC526; // c526 in hexadecimal
            3'b111: q = 16'h2F19; // 2f19 in hexadecimal
            default: q = 16'h0000; // Default case
        endcase
    end

endmodule
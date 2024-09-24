
module TopModule (
    input clk,
    input j,
    input k,
    output reg Q
);

// Always block that triggers on the positive edge of clk
always @(posedge clk) begin
    case ({j, k}) // Combine j and k into a 2-bit value
        2'b00: Q <= Q;        // Qold
        2'b01: Q <= 1'b0;     // Reset to 0
        2'b10: Q <= 1'b1;     // Set to 1
        2'b11: Q <= ~Q;       // Toggle Q
        default: Q <= Q;      // Default case (should not happen)
    endcase
end

endmodule
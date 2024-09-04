
module truthtable(
    input x3, 
    input x2, 
    input x1, 
    output reg f
);
    // Combinational logic to compute the output
    always @(*) begin
        case ({x3, x2, x1})
            3'b000: f = 1;  // 0 0 0 -> 1
            3'b001: f = 1;  // 0 0 1 -> 1
            3'b010: f = 0;  // 0 1 0 -> 0
            3'b011: f = 1;  // 0 1 1 -> 1
            3'b100: f = 0;  // 1 0 0 -> 0
            3'b101: f = 0;  // 1 0 1 -> 0
            3'b110: f = 1;  // 1 1 0 -> 1
            3'b111: f = 0;  // 1 1 1 -> 0
            default: f = 0; // Default case (just in case)
        endcase
    end
endmodule
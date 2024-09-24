
module TopModule(
    input [3:0] in,
    output reg [1:0] pos
);

always @* begin
    case(in)
        4'b0000: pos = 2'b00; // If input is zero, output zero
        4'b0001: pos = 2'b00; // 1'b1 at position 0
        4'b0010: pos = 2'b01; // 1'b1 at position 1
        4'b0011: pos = 2'b01; // 1'b1 at position 1
        4'b0100: pos = 2'b10; // 1'b1 at position 2
        4'b0101: pos = 2'b10; // 1'b1 at position 2
        4'b0110: pos = 2'b10; // 1'b1 at position 2
        4'b0111: pos = 2'b10; // 1'b1 at position 2
        4'b1000: pos = 2'b11; // 1'b1 at position 3
        4'b1001: pos = 2'b11; // 1'b1 at position 3
        4'b1010: pos = 2'b11; // 1'b1 at position 3
        4'b1011: pos = 2'b11; // 1'b1 at position 3
        4'b1100: pos = 2'b11; // 1'b1 at position 3
        4'b1101: pos = 2'b11; // 1'b1 at position 3
        4'b1110: pos = 2'b11; // 1'b1 at position 3
        4'b1111: pos = 2'b11; // 1'b1 at position 3
        default: pos = 2'b00; // Default case
    endcase
end

endmodule
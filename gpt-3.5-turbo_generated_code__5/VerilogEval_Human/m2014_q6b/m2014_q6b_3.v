module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    always @(*) begin
        case (y)
            3'b000: Y2 = 0; // State A
            3'b001: Y2 = w ? 3'b000 : 3'b001; // State B
            3'b010: Y2 = w ? 3'b100 : 3'b011; // State C
            3'b011: Y2 = w ? 3'b010 : 3'b001; // State D
            3'b100: Y2 = w ? 3'b101 : 3'b100; // State E
            3'b101: Y2 = w ? 3'b010 : 3'b001; // State F
            default: Y2 = 0;
        endcase
    end
endmodule


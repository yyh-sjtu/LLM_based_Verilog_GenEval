
module TopModule (
    input  [15:0] a,
    input  [15:0] b,
    input  [15:0] c,
    input  [15:0] d,
    input  [15:0] e,
    input  [15:0] f,
    input  [15:0] g,
    input  [15:0] h,
    input  [15:0] i,
    input  [3:0]  sel,
    output reg [15:0] out
);

always @(*) begin
    case (sel)
        4'b0000: out = a; // sel = 0 selects a
        4'b0001: out = b; // sel = 1 selects b
        4'b0010: out = c; // sel = 2 selects c
        4'b0011: out = d; // sel = 3 selects d
        4'b0100: out = e; // sel = 4 selects e
        4'b0101: out = f; // sel = 5 selects f
        4'b0110: out = g; // sel = 6 selects g
        4'b0111: out = h; // sel = 7 selects h
        4'b1000: out = i; // sel = 8 selects i
        default: out = 16'b1111111111111111; // sel = 9 to 15 sets all bits to '1'
    endcase
end

endmodule
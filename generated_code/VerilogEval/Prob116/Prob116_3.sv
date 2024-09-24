
module TopModule (
    input [3:0] x,
    output reg f
);

always @(*)
begin
    case({x[1], x[2], x[3], x[4]})
        4'b0000: f = 0;   // x[1]x[2] = 00
        4'b0001: f = 0;   // x[1]x[2] = 01
        4'b0010: f = 1;   // x[1]x[2] = 10
        4'b0011: f = 0;   // x[1]x[2] = 11
        4'b0110: f = 1;   // x[1]x[2] = 22
        4'b0111: f = 1;   // x[1]x[2] = 23
        4'b1100: f = 1;   // x[1]x[2] = 30
        4'b1101: f = 1;   // x[1]x[2] = 31
        4'b1111: f = 0;   // x[1]x[2] = 33
        default: f = 0;   // Don't care cases
    endcase
end

endmodule
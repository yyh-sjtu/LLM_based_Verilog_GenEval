
module TopModule (
    input [3:0] x,
    output reg f
);

always @* begin
    case(x)
        4'b0000: f = 1;
        4'b0001: f = 0;
        4'b0011: f = 1;
        4'b0010: f = 1;
        4'b1110: f = 0;
        4'b1111: f = 0;
        4'b1101: f = 0;
        4'b1100: f = 1;
        default: f = 0;
    endcase
end

endmodule
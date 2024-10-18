
module TopModule (
    input [3:0] x,
    output reg f
);

always @*
begin
    case ({x[2], x[3]})
        2'b00: f = x[0] | x[3];
        2'b01: f = 1'b0;
        2'b11: f = x[2] & ~x[3];
        2'b10: f = x[2] | x[0];
        default: f = 1'b0;
    endcase
end

endmodule
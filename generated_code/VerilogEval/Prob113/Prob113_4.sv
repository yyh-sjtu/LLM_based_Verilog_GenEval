
module TopModule (
    input [3:0] x,
    output reg f
);

always @* begin
    case(x[3:2])
        2'b00, 2'b10: f = 1;
        2'b11: begin
            case(x[1:0])
                2'b01, 2'b10: f = 1;
                default: f = 0;
            endcase
        end
        default: f = 0;
    endcase
end

endmodule
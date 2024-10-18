module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*)
begin
    case ({c, d})
        2'b00:
            case ({a, b})
                2'b00: out = 1'b1;
                2'b01: out = 1'b0;
                2'b10: out = 1'b1;
                2'b11: out = 1'b1;
            endcase
        2'b01:
            case ({a, b})
                2'b00: out = 1'bx; // don't care
                2'b01: out = 1'bx; // don't care
                2'b10: out = 1'bx; // don't care
                2'b11: out = 1'bx; // don't care
            endcase
        2'b10:
            case ({a, b})
                2'b00: out = 1'b0;
                2'b01: out = 1'b0;
                2'b10: out = 1'b1;
                2'b11: out = 1'b1;
            endcase
        2'b11:
            case ({a, b})
                2'b00: out = 1'b0;
                2'b01: out = 1'bx; // don't care
                2'b10: out = 1'bx; // don't care
                2'b11: out = 1'b1;
            endcase
    endcase
end

endmodule


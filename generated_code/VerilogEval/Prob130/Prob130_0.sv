
module TopModule(
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    
    output reg [3:0] q
);

always @* begin
    case({a, b, c, d, e})
        20'h0: q = 4'b0000;
        20'h1: q = 4'b0010;
        20'h2: q = 4'b1010;
        20'h3: q = 4'b0100;
        20'h4: q = 4'b1111;
        default: q = 4'b1111;
    endcase
end

endmodule
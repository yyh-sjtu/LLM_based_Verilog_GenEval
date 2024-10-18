
module TopModule(
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case({c, d, a, b})
        4'b00-: out = 1'b1;  // Corresponds to d = 0
        4'b01-: out = 1'b0;  // Corresponds to d = 0
        4'b1--: out = 1'b1;
        default: out = 1'b1; // Taking advantage of d as don't-care
    endcase
end

endmodule
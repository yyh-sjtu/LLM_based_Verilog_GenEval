
module TopModule (
    input a,
    input b,
    input sel,
    output reg out
);

always @(*) begin
    if (sel == 0) begin
        out = a;
    end else begin
        out = b;
    end
end

endmodule

module TopModule (
    input  clk,
    input  enable,
    input  S,
    input  A,
    input  B,
    input  C,
    output Z
);

reg [7:0] Q;
reg [2:0] address;

always @(posedge clk) begin
    if (enable) begin
        Q <= { Q[6:0], S };
        if (A & ~B & ~C) address <= 3'b000;
        else if (~A & B & ~C) address <= 3'b001;
        else if (A & B & ~C) address <= 3'b010;
        else if (~A & ~B & C) address <= 3'b011;
        else if (A & ~B & C) address <= 3'b100;
        else if (~A & B & C) address <= 3'b101;
        else if (A & B & C) address <= 3'b110;
        else address <= 3'b111;
    end
end

assign Z = Q[address];

endmodule
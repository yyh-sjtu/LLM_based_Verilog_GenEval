
module TopModule (
    input [6:0] y,
    input w,
    output Y1,
    output Y3
);
parameter A = 7'b000_001;
parameter B = 7'b000_010;
parameter C = 7'b000_100;
parameter D = 7'b001_000;
parameter E = 7'b010_000;
parameter F = 7'b100_000;
wire Y2;
wire Y4;

// Next-state logic equations
assign Y2 = (y == A && w) || (y == B && !w) || (y == E && w) || (y == F && !w);
assign Y4 = (y == C && !w) || (y == D && w) || (y == E && !w) || (y == F && w);
assign Y1 = Y2 && Y4;
assign Y3 = !Y2 && Y4;
endmodule
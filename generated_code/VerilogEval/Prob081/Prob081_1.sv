
module TopModule (
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    input p1e,
    input p1f,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output reg p1y,
    output reg p2y
);

reg p1y_and1, p1y_and2, p2y_and1, p2y_and2;

assign p1y = p1y_and1 | p1y_and2;
assign p2y = p2y_and1 | p2y_and2;

always @* begin
    p1y_and1 = p1a & p1b & p1c;
    p1y_and2 = p1d & p1e & p1f;
    p2y_and1 = p2a & p2b;
    p2y_and2 = p2c & p2d;
end

endmodule
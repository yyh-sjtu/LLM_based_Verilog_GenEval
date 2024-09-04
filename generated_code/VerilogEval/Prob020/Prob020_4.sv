
module TopModule (
    input [1:0] A,
    input [1:0] B,
    output reg z
);

always @(*) begin
    if (A == B) begin
        z = 1;
    end else begin
        z = 0;
    end
end

endmodule
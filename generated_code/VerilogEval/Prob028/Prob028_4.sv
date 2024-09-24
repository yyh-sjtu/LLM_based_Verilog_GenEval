
module TopModule(
    input d,
    input ena,
    output reg q
);

always @(posedge ena)
begin
    if (ena)
        q <= d;
end

endmodule
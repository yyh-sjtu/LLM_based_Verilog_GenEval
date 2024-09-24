
module TopModule(
    output reg one
);

always @(*) begin
    one = 1; // drive 1 (or logic high) on output port 'one'
end

endmodule
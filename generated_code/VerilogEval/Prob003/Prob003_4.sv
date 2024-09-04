
module TopModule (
    output reg one
);

always @(*) begin
    one = 1'b1; // drive logic high
end

endmodule
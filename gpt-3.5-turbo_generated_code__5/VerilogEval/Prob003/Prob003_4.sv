
module TopModule (
    output reg one
);

// Always drive output 'one' to logic high
always @(*) begin
    one = 1'b1;
end

endmodule
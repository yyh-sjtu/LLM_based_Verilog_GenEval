
module TopModule (
    input in,
    output reg out
);

// Behave like a wire
always @* begin
    out = in;
end

endmodule
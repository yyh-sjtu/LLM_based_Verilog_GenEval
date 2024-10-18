
module TopModule (
    input in,
    output reg out
);

// Behavior of the module
always @(in)
begin
    out <= in;
end

endmodule
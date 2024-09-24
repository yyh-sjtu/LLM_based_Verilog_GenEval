
module TopModule (
    output reg zero
);

// Set the output 'zero' to always be LOW
always @* begin
    zero = 1'b0;
end

endmodule
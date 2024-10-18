
module TopModule (
    output reg one
);

// Always drive logic high on the output port 'one'
always @* begin
    one = 1;
end

endmodule
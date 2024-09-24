
module TopModule(
    output reg out
);

always @* begin
    out = 1'b0; // always drive logic low
end

endmodule
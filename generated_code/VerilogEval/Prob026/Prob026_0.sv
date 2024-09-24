
module TopModule (
    input wire a,
    input wire b,
    output wire out_assign,
    output reg out_alwaysblock
);

// Implementing AND gate using assign statement
assign out_assign = a & b;

// Implementing AND gate using always block
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule
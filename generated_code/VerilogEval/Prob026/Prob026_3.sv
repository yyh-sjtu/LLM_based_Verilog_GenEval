
module TopModule (
    input  wire a,
    input  wire b,
    output wire out_assign,
    output reg  out_alwaysblock
);

// Assign statement for AND operation
assign out_assign = a & b;

// Combinational always block for AND operation
always @* begin
    out_alwaysblock = a & b;
end

endmodule

module TopModule (
    input  wire a,
    input  wire b,
    output wire out_assign,
    output reg  out_alwaysblock
);

// Continuous assignment using assign statement for AND operation
assign out_assign = a & b;

// Combinational logic using always block for AND operation
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule
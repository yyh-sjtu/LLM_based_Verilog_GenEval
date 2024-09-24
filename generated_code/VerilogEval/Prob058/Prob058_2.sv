
module TopModule (
    input clk,
    input a,
    input b,
    output out_assign,
    output out_always_comb,
    output out_always_ff
);

// Assign statement implementation
assign out_assign = a ^ b;

// Combinational always block implementation
always @* begin
    out_always_comb = a ^ b;
end

// Clocked always block implementation
reg out_reg;
always @(posedge clk) begin
    out_reg <= a ^ b;
end

assign out_always_ff = out_reg;

endmodule
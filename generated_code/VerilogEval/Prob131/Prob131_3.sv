
module top_module(
    input x,
    input y,
    output z
);

wire a1_out, a2_out, b1_out, b2_out, or_out, and_out;

module_A A1(.x(x), .y(y), .z(a1_out));
module_A A2(.x(x), .y(y), .z(a2_out));
module_B B1(.x(x), .y(y), .z(b1_out));
module_B B2(.x(x), .y(y), .z(b2_out));

assign or_out = a1_out | b1_out;
assign and_out = a2_out & b2_out;
assign z = or_out ^ and_out;

endmodule
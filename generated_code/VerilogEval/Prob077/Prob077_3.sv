
module TopModule (
    input  a,
    input  b,
    input  c,
    input  d,
    output out,
    output out_n
);

wire and1_output;
wire and2_output;

assign and1_output = a & b; // AND gate for inputs a and b
assign and2_output = c & d; // AND gate for inputs c and d

assign out = and1_output | and2_output; // OR gate to combine the outputs of the AND gates
assign out_n = ~out; // inverter for the 'out' output

endmodule
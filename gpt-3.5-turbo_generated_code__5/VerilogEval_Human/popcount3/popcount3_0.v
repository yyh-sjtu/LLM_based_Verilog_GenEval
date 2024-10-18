module population_count (
  input [2:0] in,
  output [1:0] out
);

  wire [2:0] a;

  assign a[2] = in[2] & in[1] & in[0];
  assign a[1] = in[2] & in[1] & !in[0] | in[2] & !in[1] & in[0] | !in[2] & in[1] & in[0];
  assign a[0] = in[2] & !in[1] & !in[0] | !in[2] & in[1] & !in[0] | !in[2] & !in[1] & in[0] | in[2] & in[1] & in[0];

  assign out = {a[2], a[1]};
  
endmodule

module top_module (
  input [2:0] in,
  output [1:0] out
);

  population_count population_count0 (
    .in(in),
    .out(out)
  );
  
endmodule


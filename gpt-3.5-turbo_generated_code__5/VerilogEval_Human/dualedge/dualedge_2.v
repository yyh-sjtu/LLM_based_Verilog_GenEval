module dual_edge_ff(
    input clk,
    input d,
    output reg q,
    reg d_ff,
    reg q_ff
  );

  always @(posedge clk) begin
    d_ff <= d;
  end

  always @(posedge clk) begin
    q_ff <= d_ff;
  end

  always @(posedge clk or negedge clk) begin
    q <= q_ff;
  end
  
endmodule

module top_module(
   input clk,
   input d,
   output reg q
 );

dual_edge_ff dual_edge_ff_inst(
   .clk(clk),
   .d(d),
   .q(q)
 );

endmodule


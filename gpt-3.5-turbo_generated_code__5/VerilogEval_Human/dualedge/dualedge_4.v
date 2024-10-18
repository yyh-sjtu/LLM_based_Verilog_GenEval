module dual_edge_ff (
  input clk,
  input d,
  output reg q,
  wire clk_posedge,
  wire clk_negedge
);

  always @ (posedge clk) begin
    clk_posedge <= 1'b1;
    clk_negedge <= 1'b0;
  end

  always @ (negedge clk) begin
    clk_posedge <= 1'b0;
    clk_negedge <= 1'b1;
  end
  
  always @ (clk_posedge or clk_negedge) begin
    if (clk_posedge) begin
      q <= d;
    end else begin
      q <= q;
    end
  end
endmodule


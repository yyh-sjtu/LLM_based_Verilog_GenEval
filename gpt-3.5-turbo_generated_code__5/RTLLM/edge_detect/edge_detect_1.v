
module edge_detect (
  input wire clk,
  input wire rst_n,
  input wire a,
  output reg rise,
  output reg down
  );

  reg a_prev;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rise <= 0;
      down <= 0;
      a_prev <= 0;
    end
    else begin
      a_prev <= a;
      if (a_prev == 0 && a == 1)
        rise <= 1;
      else if (a_prev == 1 && a == 0)
        down <= 1;
      else begin
        rise <= 0;
        down <= 0;
      end
    end
  end
endmodule
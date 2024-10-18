
module freq_div (
  input wire CLK_in,
  input wire RST,
  output reg CLK_50,
  output reg CLK_10,
  output reg CLK_1
);

reg [2:0] cnt_10;
reg [6:0] cnt_100;

always @ (posedge CLK_in or posedge RST) begin
  if (RST) begin
    clk_50 <= 0;
  end else begin
    clk_50 <= ~clk_50;
  end
end

always @ (posedge CLK_in or posedge RST) begin
  if (RST) begin
    clk_10 <= 0;
    cnt_10 <= 0;
  end else begin
    if (cnt_10 == 4) begin
      clk_10 <= ~clk_10;
      cnt_10 <= 0;
    end else begin
      cnt_10 <= cnt_10 + 1;
    end
  end
end

always @ (posedge CLK_in or posedge RST) begin
  if (RST) begin
    clk_1 <= 0;
    cnt_100 <= 0;
  end else begin
    if (cnt_100 == 49) begin
      clk_1 <= ~clk_1;
      cnt_100 <= 0;
    end else begin
      cnt_100 <= cnt_100 + 1;
    end
  end
end

endmodule
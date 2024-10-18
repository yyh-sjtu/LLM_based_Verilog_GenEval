
module freq_div (
  input wire CLK_in,
  input wire RST,
  output wire CLK_50,
  output wire CLK_10,
  output wire CLK_1
);

  reg CLK_50;
  reg CLK_10;
  reg CLK_1;
  
  reg [2:0] cnt_10;
  reg [5:0] cnt_100;
  
  always @(posedge CLK_in or posedge RST) begin
    if (RST)
      CLK_50 <= 0;
    else
      CLK_50 <= ~CLK_50;
  end
  
  always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
      CLK_10 <= 0;
      cnt_10 <= 0;
    end else begin
      if (cnt_10 == 4) begin
        CLK_10 <= ~CLK_10;
        cnt_10 <= 0;
      end else
        cnt_10 <= cnt_10 + 1;
    end
  end
  
  always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
      CLK_1 <= 0;
      cnt_100 <= 0;
    end else begin
      if (cnt_100 == 49) begin
        CLK_1 <= ~CLK_1;
        cnt_100 <= 0;
      end else
        cnt_100 <= cnt_100 + 1;
    end
  end

endmodule
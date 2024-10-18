
module freq_div (
  input wire CLK_in,
  input wire RST,
  output wire CLK_50,
  output wire CLK_10,
  output wire CLK_1
);
  
  reg CLK_50_reg;
  reg [3:0] cnt_10;
  reg [5:0] cnt_100;

  always @(posedge CLK_in or posedge RST) begin
    if (RST)
      CLK_50_reg <= 1'b0;
    else
      CLK_50_reg <= ~CLK_50_reg;
  end

  always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
      CLK_10 <= 1'b0;
      cnt_10 <= 4'b0;
    end
    else begin
      if (cnt_10 == 4'b0011) begin
        CLK_10 <= ~CLK_10;
        cnt_10 <= 4'b0;
      end
      else begin
        cnt_10 <= cnt_10 + 4'b1;
      end
    end
  end

  always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
      CLK_1 <= 1'b0;
      cnt_100 <= 6'b0;
    end
    else begin
      if (cnt_100 == 6'b110001) begin
        CLK_1 <= ~CLK_1;
        cnt_100 <= 6'b0;
      end
      else begin
        cnt_100 <= cnt_100 + 6'b1;
      end
    end
  end

  assign CLK_50 = CLK_50_reg;

endmodule

module freq_div (
  input wire CLK_in,
  input wire RST,
  output wire CLK_50,
  output wire CLK_10,
  output wire CLK_1
);

  reg toggle_50, toggle_10, toggle_1;
  reg [3:0] cnt_10, cnt_100;

  // CLK_50 generation
  always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
      CLK_50 <= 1'b0;
    end else begin
      CLK_50 <= ~CLK_50;
    end
  end

  // CLK_10 generation
  always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
      CLK_10 <= 1'b0;
      cnt_10 <= 4'b0;
    end else begin
      if (cnt_10 == 4'b1001) begin
        CLK_10 <= ~CLK_10;
        cnt_10 <= 4'b0;
      end else begin
        cnt_10 <= cnt_10 + 1'b1;
      end
    end
  end

  // CLK_1 generation
  always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
      CLK_1 <= 1'b0;
      cnt_100 <= 6'b0;
    end else begin
      if (cnt_100 == 6'b110001) begin
        CLK_1 <= ~CLK_1;
        cnt_100 <= 6'b0;
      end else begin
        cnt_100 <= cnt_100 + 1'b1;
      end
    end
  end

endmodule
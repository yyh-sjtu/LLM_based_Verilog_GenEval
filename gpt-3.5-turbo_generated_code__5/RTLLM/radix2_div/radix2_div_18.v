
module radix2_div (
  input clk,
  input rst,
  input sign,
  input [7:0] dividend,
  input [7:0] divisor,
  input opn_valid,
  output reg res_valid,
  output reg [15:0] result
);

  reg [15:0] SR;
  reg [7:0] NEG_DIVISOR;
  reg [3:0] cnt;
  reg start_cnt;

  always @ (posedge clk or posedge rst)
  begin 
    if (rst == 1'b1) begin
      res_valid <= 1'b0;
      SR <= 16'd0;
      NEG_DIVISOR <= 8'd0;
      cnt <= 4'd0;
      start_cnt <= 1'b0;
    end else begin
      if (opn_valid && !res_valid) begin
        SR <= {dividend, 8'd0};
        NEG_DIVISOR <= ~divisor + 1;
        cnt <= 4'd1;
        start_cnt <= 1'b1;
      end
      if (start_cnt) begin
        if (cnt == 4'd8) begin
          start_cnt <= 1'b0;
          cnt <= 4'd0;
          res_valid <= 1'b1;
          result <= {SR[15:8], SR[7:0]};
        end else begin
          cnt <= cnt + 4'd1;
          if (SR[15:8] >= NEG_DIVISOR) begin
            SR <= {SR[15:1], 1'b0};
          end else begin
            SR <= {SR[15:1], 1'b1};
          end
        end
      end
    end
  end

endmodule
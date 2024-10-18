module radix2_div (
  input wire clk,
  input wire rst,
  input wire sign,
  input wire [7:0] dividend,
  input wire [7:0] divisor,
  input wire opn_valid,
  output reg res_valid,
  output reg [15:0] result
);

  reg [10:0] SR;
  reg [8:0] NEG_DIVISOR;
  reg [3:0] cnt;
  reg start_cnt;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      SR <= 0;
      NEG_DIVISOR <= 0;
      cnt <= 0;
      start_cnt <= 0;
      res_valid <= 0;
    end else begin
      if (opn_valid && !res_valid) begin
        SR <= {1'b0, abs(dividend), 7'b0};
        NEG_DIVISOR <= -abs(divisor);
        cnt <= 1;
        start_cnt <= 1;
        res_valid <= 0;
      end else begin
        if (start_cnt) begin
          if (cnt == 8) begin
            start_cnt <= 0;
            cnt <= 0;
            SR <= {SR[8:1]};
            res_valid <= 1;
          end else begin
            cnt <= cnt + 1;
            {SR, carry_out} <= SR - {1'b0, NEG_DIVISOR};
            SR <= {carry_out, SR[8:1]};
          end
        end
      end
    end
  end

  always @(*) begin
    if (res_valid) begin
      result = {SR[8:1], SR[9]};
    end else begin
      result = 16'b0;
    end
  end

endmodule


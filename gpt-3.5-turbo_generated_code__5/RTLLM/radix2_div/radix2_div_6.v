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

  reg [11:0] SR;  // shift register for division
  reg [11:0] NEG_DIVISOR;  // negated absolute value of divisor
  reg [3:0] cnt;  // counter for division process
  reg start_cnt;  // start signal for division process

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      res_valid <= 0;
      SR <= 0;
      NEG_DIVISOR <= 0;
      cnt <= 0;
      start_cnt <= 0;
    end else begin
      if (opn_valid && ~res_valid) begin  // operation start
        SR <= {dividend, 1'b0};  // initialize shift register with dividend
        NEG_DIVISOR <= ~divisor + 1;  // compute negated absolute value of divisor
        cnt <= 4'd1;  // initialize counter
        start_cnt <= 1;  // signal to start division process
      end

      if (start_cnt) begin  // division process
        if (cnt == 4'd8) begin  // division complete
          SR <= SR[7:0];  // update shift register with remainder in upper 8 bits
          SR[7:0] <= 8'd0;  // clear lower 8 bits for quotient
          cnt <= 4'd0;  // clear counter
          start_cnt <= 0;  // clear start signal
          res_valid <= 1;  // signal result is valid
        end else begin
          cnt <= cnt + 1;  // increment counter
          if (sign) begin  // signed division
            if (SR[11]) begin  // MSB of SR is set (result is negative), perform addition
              SR <= SR + NEG_DIVISOR;  // add negated divisor to SR
              if (SR[11]) begin  // carry-out is still set, indicate negative result
                SR[11] <= 0;  // clear carry-out
                result <= {1'b1, SR};  // set sign bit in result
              end else begin
                result <= SR;  // result is positive
              end
            end else begin  // MSB of SR is clear (result is positive), perform subtraction
              SR <= SR - NEG_DIVISOR;  // subtract negated divisor from SR
              result <= SR;  // result is positive
            end
          end else begin  // unsigned division
            if (SR[11]) begin  // MSB of SR is set (result is negative), perform addition
              SR <= SR + NEG_DIVISOR;  // add negated divisor to SR
              result <= SR;  // result is positive
            end else begin  // MSB of SR is clear (result is positive), perform subtraction
              SR <= SR - NEG_DIVISOR;  // subtract negated divisor from SR
              result <= SR;  // result is positive
            end
          end
          SR <= {SR[10:0], SR[11]};  // shift left and insert carry-out as new MSB
        end
      end
    end
  end
endmodule


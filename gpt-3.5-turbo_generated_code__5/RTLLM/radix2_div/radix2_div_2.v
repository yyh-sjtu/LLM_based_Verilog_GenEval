
module radix2_div (
  input wire clk,        // Clock signal
  input wire rst,        // Reset signal
  input wire sign,       // Sign flag for signed or unsigned division
  input wire [7:0] dividend,     // Dividend input
  input wire [7:0] divisor,      // Divisor input
  input wire opn_valid,  // Operation valid signal

  output wire res_valid, // Result valid signal
  output wire [15:0] result     // Result output (remainder in upper 8 bits, quotient in lower 8 bits)
);

  reg [15:0] shift_reg;      // Shift register to store dividend and perform division
  reg [7:0] NEG_DIVISOR;     // Negated absolute value of the divisor
  reg [3:0] cnt;             // Counter for division process
  reg start_cnt;             // Start counter for division process

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset signals and registers
      shift_reg <= 0;
      cnt <= 0;
      start_cnt <= 0;
      res_valid <= 0;
    end else begin
      if (opn_valid && !res_valid) begin
        // Start of operation
        shift_reg <= {1'b0, dividend};
        NEG_DIVISOR <= (sign && dividend[7]) ? -divisor : divisor;
        cnt <= 1;
        start_cnt <= 1;
      end else if (start_cnt) begin
        // Division process
        if (cnt == 8) begin
          // Division complete
          cnt <= 0;
          start_cnt <= 0;
          shift_reg <= {shift_reg[15:8], shift_reg[7:0]};
          res_valid <= 1;
        end else begin
          // Perform subtraction and update shift register
          reg [15:0] temp_shift_reg;
          reg carryout;

          temp_shift_reg = shift_reg - NEG_DIVISOR;
          carryout = temp_shift_reg[15];

          shift_reg <= {temp_shift_reg[14:0], carryout};
          cnt <= cnt + 1;
        end
      end else begin
        // Result consumed, reset result valid signal
        res_valid <= 0;
      end
    end
  end

  // Assign result output with remainder in upper 8 bits and quotient in lower 8 bits
  assign result = {shift_reg[15:8], shift_reg[7:0]};

endmodule
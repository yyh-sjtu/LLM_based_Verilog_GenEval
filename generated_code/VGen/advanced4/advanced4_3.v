module advshift(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

  // internal registers
  reg [63:0] shift_reg;

  always @(posedge clk) begin
    if (load) begin
      if (ena) begin
        case (amount)
          2'b00: shift_reg <= {shift_reg[62:0], 1'b0}; // shift left by 1 bit
          2'b01: shift_reg <= {shift_reg[55:0], 8'b00000000}; // shift left by 8 bits
          2'b10: shift_reg <= {1'b0, shift_reg[63:1]}; // shift right by 1 bit
          2'b11: shift_reg <= {8'b00000000, shift_reg[63:8]}; // shift right by 8 bits
        endcase
      end
    end
    q <= shift_reg;
  end

endmodule


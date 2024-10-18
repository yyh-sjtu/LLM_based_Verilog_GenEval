
module TopModule (
  input  wire clk,
  input  wire load,
  input  wire ena,
  input  wire [1:0] amount,
  input  wire [63:0] data,
  output wire [63:0] q
);

  reg [63:0] shift_reg; // Shift register

  always @(posedge clk) begin
    if (load) begin
      shift_reg <= data;
    end else if (ena) begin
      case (amount)
        2'b00: shift_reg <= shift_reg << 1; // Shift left by 1 bit
        2'b01: shift_reg <= shift_reg << 8; // Shift left by 8 bits
        2'b10: shift_reg <= shift_reg >>> 1; // Shift right by 1 bit (arithmetic right shift)
        2'b11: shift_reg <= shift_reg >>> 8; // Shift right by 8 bits (arithmetic right shift)
      endcase
    end
  end

  assign q = shift_reg;

endmodule
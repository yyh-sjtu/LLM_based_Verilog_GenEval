module TopModule(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

// Registers
reg [3:0] shift_reg;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    shift_reg <= 4'b0; // Reset shift register to zero
  end else if (load) begin
    shift_reg <= data; // Load shift register with data[3:0]
  end else if (ena) begin
    shift_reg <= {shift_reg[2:0], 1'b0}; // Shift right (q[3] becomes zero, q[0] is shifted out)
  end
end

// Output
assign q = shift_reg;

endmodule


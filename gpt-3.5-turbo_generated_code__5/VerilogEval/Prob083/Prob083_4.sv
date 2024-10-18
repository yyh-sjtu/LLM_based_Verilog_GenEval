
module TopModule (
  input x,
  input y,
  output z
);

  reg z_reg;    // Register to store the value of output z

  always @(x, y) begin
    case({x, y})
      2'b00: z_reg <= 1;    // If x = 0 and y = 0, set z to 1
      2'b01: z_reg <= 0;    // If x = 0 and y = 1, set z to 0
      2'b10: z_reg <= 0;    // If x = 1 and y = 0, set z to 0
      2'b11: z_reg <= 1;    // If x = 1 and y = 1, set z to 1
    endcase
  end

  assign z = z_reg;

endmodule
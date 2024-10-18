
module TopModule (
  input  wire clk,
  input  wire areset,
  input  wire x,
  output wire z
);

  reg [1:0] state;
  reg [1:0] next_state;
  reg z_reg;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00;
      z_reg <= 1'b0;
    end
    else begin
      state <= next_state;
      z_reg <= (state == 2'b01) ? ~z_reg : z_reg;
    end
  end

  always @(state, x) begin
    case (state)
      2'b00: next_state = x ? 2'b01 : 2'b00;
      2'b01: next_state = 2'b00;
    endcase
  end

  assign z = z_reg;

endmodule
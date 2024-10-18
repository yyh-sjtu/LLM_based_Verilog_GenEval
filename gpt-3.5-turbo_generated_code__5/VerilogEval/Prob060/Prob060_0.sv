
module TopModule (
  input  wire         clk,
  input  wire         resetn,
  input  wire         in,
  output wire         out
);

  reg [3:0] shift_reg;

  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      shift_reg <= 4'd0;
    end else begin
      shift_reg <= {shift_reg[2:0], in};
    end
  end

  assign out = shift_reg[3];

endmodule
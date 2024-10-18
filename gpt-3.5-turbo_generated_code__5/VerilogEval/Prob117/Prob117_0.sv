
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a) begin
      case(q)
        0: q <= 4;
        4: q <= 5;
        5: q <= 6;
        default: q <= 4;
      endcase
    end
  end

endmodule
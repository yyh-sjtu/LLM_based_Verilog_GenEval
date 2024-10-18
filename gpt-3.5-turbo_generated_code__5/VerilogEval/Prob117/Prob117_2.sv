
module TopModule(
  input  clk,
  input  a,
  output [2:0] q
);

reg [2:0] q_next;

always @(posedge clk)
begin
  if (a == 1'b1)
  begin
    case(q)
      3'b000: q_next = 3'b100;
      3'b100: q_next = 3'b100;
      3'b101: q_next = 3'b100;
      3'b110: q_next = 3'b100;
      3'b111: q_next = 3'b100;
      default: q_next = 3'b000; // Just to handle unknown state
    endcase
  end
  else
    q_next = q;
end

assign q = q_next;

endmodule
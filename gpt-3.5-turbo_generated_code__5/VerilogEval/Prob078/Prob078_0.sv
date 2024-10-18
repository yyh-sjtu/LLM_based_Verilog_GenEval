
module TopModule (
  input  wire clk,
  input  wire d,
  output reg  q
);

// Internal flip-flop signals
reg q_ff1;
reg q_ff2;

always @(posedge clk) begin
  q_ff1 <= d;
end

always @(negedge clk) begin
  q_ff2 <= q_ff1;
  q <= q_ff2;
end

endmodule
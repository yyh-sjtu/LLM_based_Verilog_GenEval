
module TopModule (
  input clk,
  input reset,
  output [3:0] q
);

reg [3:0] counter;

always @(posedge clk) begin
  if (reset)
    counter <= 0;
  else if (counter == 9)
    counter <= 0;
  else
    counter <= counter + 1;
end

assign q = counter;

endmodule
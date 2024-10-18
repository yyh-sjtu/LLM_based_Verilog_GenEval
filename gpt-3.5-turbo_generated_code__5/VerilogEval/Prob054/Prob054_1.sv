
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
  // Store previous input value
  prev_in <= in;
  
  // Detect 0 to 1 transitions and set output bit accordingly
  pedge <= (in & ~prev_in);
end

endmodule

module TopModule (
  input  wire clk,
  input  wire reset,
  output wire shift_ena
);

  reg [2:0] count;

  always @(posedge clk) begin
    if (reset)
      count <= 3'b111;
    else if (count > 3'b000)
      count <= count - 1;
    else
      count <= 3'b000;
  end

  assign shift_ena = (count > 3'b000);

endmodule
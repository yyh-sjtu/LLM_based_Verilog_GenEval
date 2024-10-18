
module TopModule (
  input clk,
  input resetn,
  input in,
  output reg out
);

  reg [3:0] dff; // four D flops for shift register

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      dff <= 4'b0; // reset the shift register
    end else begin
      dff <= {dff[2:0], in}; // shift in the new value
    end
  end

  assign out = dff[3]; // output the most significant bit of shift register

endmodule
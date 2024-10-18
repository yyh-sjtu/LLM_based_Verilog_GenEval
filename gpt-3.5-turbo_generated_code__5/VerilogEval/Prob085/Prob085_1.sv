
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output [3:0] q
);
  reg [4:0] shift_register;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      shift_register <= 0;
    end else if (load) begin
      shift_register <= {1'b0, data[3:0]};
    end else if (ena) begin
      shift_register <= {shift_register[3:1], 1'b0};
    end
  end

  assign q = shift_register[3:0];
endmodule
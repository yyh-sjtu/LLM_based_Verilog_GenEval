
module TopModule (
  input clk,
  input resetn,
  input in,
  output reg out
);
  
  reg [3:0] shift_register;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      shift_register <= 4'b0;
    end else begin
      shift_register <= {in, shift_register[3:1]};
    end
  end
  
  assign out = shift_register[0];
  
endmodule
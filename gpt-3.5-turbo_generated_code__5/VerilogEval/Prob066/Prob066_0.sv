
module TopModule (
  input  wire clk,
  input  wire reset,
  input  wire [31:0] in,
  output wire [31:0] out
);

  reg [31:0] register;
  reg [31:0] next_register;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      register <= 32'b0;
    end else begin
      register <= next_register;
    end
  end

  always @(*) begin
    next_register = register;
    for (integer i = 0; i < 32; i = i + 1) begin
      if (in[i] && ~register[i]) begin
        next_register[i] = 1;
      end else if (~in[i] && register[i]) begin
        next_register[i] = 0;
      end
    end
  end
  
  assign out = register;

endmodule
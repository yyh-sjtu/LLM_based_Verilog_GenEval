module TopModule (
  input  wire clk,
  input  wire [7:0] d,
  output wire [7:0] q
);
  reg [7:0] q_reg;  // Register to store the output

  always @(posedge clk) begin
    q_reg <= d;  // Update the register with the input value on positive clock edge
  end

  assign q = q_reg;  // Assign the register value to the output
endmodule


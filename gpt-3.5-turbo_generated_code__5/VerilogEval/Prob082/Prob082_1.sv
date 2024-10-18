module TopModule(
  input clk,
  input reset,
  output reg [31:0] q
);

  reg [31:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 32'h1;  // Reset output q to 32'h1
    end else begin
      state <= {state[31]^state[21]^state[1]^state[0], state[31:1]};  // Galois LFSR logic
    end
  end

  assign q = state;  // Output q is the current state of the LFSR

endmodule


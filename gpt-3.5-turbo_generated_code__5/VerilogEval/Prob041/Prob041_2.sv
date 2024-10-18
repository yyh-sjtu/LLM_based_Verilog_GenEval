
module TopModule(
  input  clk,
  input  reset,
  input  [7:0] d,
  output reg [7:0] q
);

  // D flip-flops declaration
  reg [7:0] q_tmp;
  reg [7:0] q_next;
  
  always @(posedge clk) begin
    if (reset) begin
      q_tmp <= 8'b0; // Reset the temporary output
    end else begin
      q_tmp <= q_next; // Update the temporary output
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      q_next <= 8'b0; // Reset the next output
    end else begin
      q_next <= d; // Update the next output with input d
    end
  end

  // Output assignment
  always @(posedge clk) begin
    q <= q_tmp; // Assign the output from the temporary output
  end

endmodule
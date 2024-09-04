module named `TopModule` that meets the specified requirements. It includes 8 D flip-flops with an active-high asynchronous reset.

```systemverilog
module TopModule (
    input logic clk,        // Clock input
    input logic areset,     // Asynchronous reset input
    input logic [7:0] d,    // 8-bit data input
    output logic [7:0] q     // 8-bit data output
);

  // 8 D Flip-Flops
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      q <= 8'b0;  // Reset output to 0
    end else begin
      q <= d;     // Update the output with input data
    end
  end

endmodule


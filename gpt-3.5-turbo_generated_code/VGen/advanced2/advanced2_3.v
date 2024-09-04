module decade_counter (
  input clk,     // Clock input
  input slowena, // Slow enable input
  input reset,   // Reset signal input
  output reg [3:0] q // Output of the decade counter
);

  // Local Parameters
  parameter COUNT_MAX = 4'b1001; // Maximum count value for a decade counter

  // Internal Registers
  reg [3:0] count_reg; // Register to store the count value

  // Always block for counting logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count_reg <= 4'b0000; // Reset the count value
    end else begin
      if (slowena) begin
        if (count_reg == COUNT_MAX) begin
          count_reg <= 4'b0000; // Reset the count value when maximum count is reached
        end else begin
          count_reg <= count_reg + 1; // Increment count value
        end
      end
    end
  end

  // Assigning output
  assign q = count_reg;

endmodule


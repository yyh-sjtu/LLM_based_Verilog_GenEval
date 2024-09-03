module counter(
  input clk,   // Clock input
  input reset, // Reset input
  output reg [3:0] q // 4-bit output representing the count
);

  // Define a 4-bit reg to hold the count
  reg [3:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset the count to 1 when reset is high
      count <= 4'b0001;
    end else begin
      // Increment the count by 1 every clock cycle
      if (count == 4'b1100) begin
        count <= 4'b0001; // Reset count to 1 when it reaches 12
      end else begin
        count <= count + 4'b0001; // Increment count by 1
      end
    end
  end

  // Assign the count value to the output q
  assign q = count;

endmodule


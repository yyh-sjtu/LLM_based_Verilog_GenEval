module
module counter( 
    input clk,      // Clock signal
    input reset,    // Reset signal
    output reg [3:0] q  // 4-bit output signal
);
  
  // Initialize a 4-bit register to store the count
  reg [3:0] count;
  
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      count <= 4'b0000; // Reset the count to 0
    end
    else begin
      // Increment the count from 1 to 12
      if (count == 4'b1100) begin
        count <= 4'b0001; // Reset count to 1
      end
      else begin
        count <= count + 1; // Increment count by 1
      end
    end
  end
  
  // Assign the count to the output port
  assign q = count;
  
endmodule


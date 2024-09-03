
module lfsr( 
  input clk,
  input reset,
  output reg [4:0] q
); 
  reg [4:0] r_reg;
  wire [4:0] r_next;
  wire feedback_value;
  
  // Feedback logic for taps at bit positions 5 and 3
  assign feedback_value = r_reg[4] ^ r_reg[2];
  
  // D flip-flop for storage of the current state
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      r_reg <= 5'b1;
    end else begin
      r_reg <= r_next;
    end
  end
  
  // Feedback XOR feedback_value with the current state to get the next state
  assign r_next = {feedback_value, r_reg[4:1]};
  
  // Output the current state
  assign q = r_reg;
  
endmodule
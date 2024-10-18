
module TopModule (
  input  clk,
  input  reset,
  input  in,
  output out
);
 
  reg [1:0] state;
  reg       next_state;
  reg       output_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state       <= 2'b00;   // Reset to state A
      output_reg  <= 1'b0;    // Reset output to 0
    end
    else begin
      state       <= next_state;
      output_reg  <= output_reg;  // Output does not change in this FSM
    end
  end
  
  always @(state or in) begin
    case (state)
      2'b00: begin
        if (in)
          next_state = 2'b10;   // Transition from state A to D on input=1
        else
          next_state = 2'b01;   // Transition from state A to B on input=0
      end
      
      2'b01: begin
        if (in)
          next_state = 2'b01;   // Remain in state B on input=1
        else
          next_state = 2'b10;   // Transition from state B to C on input=0
      end
      
      2'b10: begin
        if (in)
          next_state = 2'b11;   // Transition from state C to D on input=1
        else
          next_state = 2'b00;   // Transition from state C to A on input=0
      end
      
      2'b11: begin
        if (in)
          next_state = 2'b01;   // Transition from state D to B on input=1
        else
          next_state = 2'b10;   // Remain in state D on input=0
      end
    endcase
  end
  
  assign out = output_reg;
  
endmodule
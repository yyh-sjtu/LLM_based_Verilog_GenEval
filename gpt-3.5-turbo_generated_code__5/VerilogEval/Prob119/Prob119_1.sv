module TopModule (
  input  logic clk,
  input  logic areset,
  input  logic in,
  output logic out
);

  typedef enum logic [1:0] {A, B, C, D} state_t; // Define state types
  
  state_t current_state, next_state; // Variables to keep track of current and next state

  always_ff @(posedge clk or posedge areset) begin
    if (areset) // Asynchronous reset
      current_state <= A;
    else
      current_state <= next_state; // Update current state based on next state
    
    case (current_state) // State transition logic
      A: begin
        if (in)
         next_state <= B;
        else
         next_state <= A;
      end
      
      B: begin
        if (in)
          next_state <= B;
        else
          next_state <= C;
      end
      
      C: begin
        if (in)
          next_state <= D;
        else
          next_state <= A;
      end
      
      D: begin
        if (in)
          next_state <= B;
        else
          next_state <= C;
      end
    endcase
  end

  always_comb begin
    case (current_state)
      A: out = 0;
      B: out = 0;
      C: out = 0;
      D: out = 1;
    endcase
  end

endmodule


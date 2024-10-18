
module fsm (
  input wire IN,
  input wire CLK,
  input wire RST,
  output wire MATCH
);
  
  // FSM states
  localparam S0 = 2'b00;  // Initial state
  localparam S1 = 2'b01;  // State after detecting 1
  localparam S2 = 2'b10;  // Final state after detecting 10011
  
  // Internal signals
  reg [1:0] state, next_state;
  
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      state <= S0;  // Reset the FSM to initial state
    end else begin
      state <= next_state;  // Update the FSM state
    end
  end
  
  always @(state or IN) begin
    case (state)
      S0: begin
        if (IN) begin
          next_state = S1;  // Transition to state S1 on IN=1
        end else begin
          next_state = S0;  // Stay in state S0 on IN=0
        end
        MATCH = 0;  // Output MATCH is always 0 in S0
      end
      S1: begin
        if (IN) begin
          next_state = S1;  // Stay in state S1 on IN=1
        end else begin
          next_state = S2;  // Transition to state S2 on IN=0
        end
        MATCH = 0;  // Output MATCH is always 0 in S1
      end
      S2: begin
        if (IN) begin
          next_state = S1;  // Transition back to state S1 on IN=1
          MATCH = 1;       // Output MATCH is 1 in S2 on IN=1
        end else begin
          next_state = S0;  // Transition back to state S0 on IN=0
          MATCH = 0;       // Output MATCH is always 0 in S2 on IN=0
        end
      end
      default: begin
        next_state = S0;  // Reset to initial state on unknown state
        MATCH = 0;       // Output MATCH is always 0 in unknown state
      end
    endcase
  end
  
endmodule

module fsm(
  input wire IN,
  input wire CLK,
  input wire RST,
  output reg MATCH
);

  reg [4:0] state;

  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      state <= 5'b0;
      MATCH <= 0;
    end
    else begin
      case (state)
        5'b00000: begin // Initial state
          if (IN) state <= 5'b00001; // Transition to state 1 if IN=1
        end
        5'b00001: begin
          if (!IN) state <= 5'b00010; // Transition to state 2 if IN=0
        end
        5'b00010: begin
          if (!IN) state <= 5'b00011; // Transition to state 3 if IN=0
        end
        5'b00011: begin
          if (IN) state <= 5'b00100; // Transition to state 4 if IN=1
        end
        5'b00100: begin
          if (IN) state <= 5'b00101; // Transition to state 5 if IN=1
          MATCH <= 1; // Set MATCH=1 when entering state 5
        end
        5'b00101: begin
          if (IN) state <= 5'b00001; // Transition back to state 1 if IN=1
        end
        default: begin
          state <= 5'b0; // Reset to initial state
          MATCH <= 0;
        end
      endcase
    end
  end

endmodule
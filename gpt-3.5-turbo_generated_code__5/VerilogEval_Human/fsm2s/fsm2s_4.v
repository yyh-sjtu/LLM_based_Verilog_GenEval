module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

reg [1:0] state; // Two-state variable to represent the current state

always @(posedge clk, posedge reset) begin
  if(reset)
    state <= 2'b00; // Initial state is OFF
  else begin
    case(state)
      2'b00: // OFF state
        begin
          if(j)
            state <= 2'b01; // Transition to ON state when j=1
        end
      2'b01: // ON state
        begin
          if(k)
            state <= 2'b00; // Transition to OFF state when k=1
        end
      default:
        state <= 2'b00; // Default state is OFF
    endcase
  end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is 1 when in ON state, 0 otherwise

endmodule


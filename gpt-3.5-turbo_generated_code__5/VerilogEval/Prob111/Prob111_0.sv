
module TopModule (
  input  clk,
  input  reset,
  input  j,
  input  k,
  output reg out
);

  // Declare internal state variable
  reg [1:0] state;

  // Moore state machine logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b0; // Set initial state to OFF
      out <= 1'b0;   // Set initial output to 0
    end else begin
      case (state)
        2'b00: begin // OFF state
          if (j) begin
            state <= 2'b01; // Transition to ON state when j=1
            out <= 1'b0;    // Set output to 0
          end else begin
            state <= 2'b00; // Remain in OFF state when j=0
            out <= 1'b0;    // Set output to 0
          end
        end
        2'b01: begin // ON state
          if (k) begin
            state <= 2'b00; // Transition to OFF state when k=1
            out <= 1'b1;    // Set output to 1
          end else begin
            state <= 2'b01; // Remain in ON state when k=0
            out <= 1'b1;    // Set output to 1
          end
        end
      endcase
    end
  end

endmodule
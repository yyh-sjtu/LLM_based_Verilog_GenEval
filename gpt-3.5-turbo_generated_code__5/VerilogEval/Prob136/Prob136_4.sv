
module TopModule (
  input  wire clk,
  input  wire reset,
  input  wire w,
  output wire z
);
  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000;  // Initialize state to A (0)
    else begin
      case (state)
        3'b000: // A (0)
          if (w)
            state <= 3'b000;  // Stay in A (0)
          else
            state <= 3'b001;  // Transition to B (0)
        3'b001: // B (0)
          if (w)
            state <= 3'b010;  // Transition to D (0)
          else
            state <= 3'b011;  // Transition to C (0)
        3'b010: // C (0)
          if (w)
            state <= 3'b011;  // Transition to D (0)
          else
            state <= 3'b100;  // Transition to E (1)
        3'b011: // D (0)
          if (w)
            state <= 3'b000;  // Transition to A (0)
          else
            state <= 3'b101;  // Transition to F (1)
        3'b100: // E (1)
          if (w)
            state <= 3'b101;  // Transition to F (1)
          else
            state <= 3'b100;  // Stay in E (1)
        3'b101: // F (1)
          if (w)
            state <= 3'b010;  // Transition to C (0)
          else
            state <= 3'b101;  // Stay in F (1)
      endcase
    end
  end

  assign z = (state == 3'b100 || state == 3'b110) ? 1'b1 : 1'b0;

endmodule
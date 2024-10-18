
module TopModule (
  input  clk,
  input  reset,
  input  w,
  output reg z
);

  // Define states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  parameter E = 2'b100;
  parameter F = 2'b101;

  // Declare state variables
  reg [2:0] state, next_state;

  // State transition logic
  always @(posedge clk) begin
    if (reset)
      state <= A;
    else
      state <= next_state;
  end

  // Output logic
  always @(state, w) begin
    case (state)
      A: begin
        if (w)
          next_state = B;
        else
          next_state = A;
      end
      B: begin
        if (w)
          next_state = C;
        else
          next_state = D;
      end
      C: begin
        if (w)
          next_state = E;
        else
          next_state = D;
      end
      D: begin
        if (w)
          next_state = F;
        else
          next_state = A;
      end
      E: begin
        if (w)
          next_state = E;
        else
          next_state = D;
      end
      F: begin
        if (w)
          next_state = C;
        else
          next_state = D;
      end
      default: next_state = A;
    endcase
  end

  // Output assignment
  always @(state) begin
    case (state)
      A, B, C, D: z = 0;
      E, F: z = 1;
      default: z = 0;
    endcase
  end

endmodule
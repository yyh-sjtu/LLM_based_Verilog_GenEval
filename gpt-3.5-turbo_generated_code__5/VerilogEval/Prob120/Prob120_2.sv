
module TopModule (
  input clk,
  input reset,
  input in,
  output reg out
);

  // Define the four states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  // Define the state machine registers
  reg [1:0] current_state;
  reg [1:0] next_state;

  // Define the output register
  // Note: We use 'reg' instead of 'output reg' to allow for direct assignment in always blocks
  reg out_reg;

  // State transition logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end

  // Output logic
  always @(current_state) begin
    case (current_state)
      A: begin
        next_state = in ? B : A;
        out_reg = 1'b0;
      end
      B: begin
        next_state = in ? B : C;
        out_reg = 1'b0;
      end
      C: begin
        next_state = in ? D : A;
        out_reg = 1'b0;
      end
      D: begin
        next_state = in ? B : C;
        out_reg = 1'b1;
      end
    endcase
  end

  // Assign output
  always @(posedge clk) begin
    if (reset) begin
      out <= 1'b0;
    end else begin
      out <= out_reg;
    end
  end

endmodule
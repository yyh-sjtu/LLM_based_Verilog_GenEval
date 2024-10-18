
module TopModule(
  input clk,
  input areset,
  input x,
  output reg z
);

  // Enumerated type for states
  typedef enum logic [1:0] {
    A, B
  } state_e;

  // Current state and next state signals
  reg [1:0] current_state;
  reg [1:0] next_state;
  
  // State transition and output logic
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    case (current_state)
      A: begin
        if (x) begin
          next_state = B;
          z = 1'b1;
        end else begin
          next_state = A;
          z = 1'b0;
        end
      end
      
      B: begin
        if (x) begin
          next_state = B;
          z = 1'b0;
        end else begin
          next_state = B;
          z = 1'b1;
        end
      end
    endcase
  end

endmodule
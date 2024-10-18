module top_module (
    input clk,
    input in,
    input areset,
    output out
);
 
  // Define the states
  parameter B = 1'b0;
  parameter A = 1'b1;

  reg state;
 
  // Next state logic
  always @(posedge clk, posedge areset) begin
    if (areset) begin
      state <= B;
    end else begin
      case(state)
        B: begin
          if (in)
            state <= B;
          else
            state <= A;
        end
        A: begin
          if (in)
            state <= A;
          else
            state <= B;
        end
      endcase
    end
  end
 
  // Output logic
  always @(state, in) begin
    case(state)
      B: out = 1'b1;
      A: out = 1'b0;
    endcase
  end
 
endmodule


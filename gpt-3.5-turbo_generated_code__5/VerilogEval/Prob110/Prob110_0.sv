
module TopModule (
  input clk,
  input areset,
  input j,
  input k,
  output reg out
);

  // Define the two states
  parameter OFF = 1'b0;
  parameter ON = 1'b1;
  
  // Declare the state register and assign initial state
  reg state_reg;
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state_reg <= OFF;
    end else begin
      case(state_reg)
        OFF: begin
          if (j) begin
            state_reg <= ON;
          end else begin
            state_reg <= OFF;
          end
        end
        ON: begin
          if (k) begin
            state_reg <= OFF;
          end else begin
            state_reg <= ON;
          end
        end
        default: state_reg <= OFF;
      endcase
    end
  end
  
  // Output logic
  always @(state_reg) begin
    case(state_reg)
      OFF: out = 1'b0;
      ON: out = 1'b1;
      default: out = 1'b0;
    endcase
  end

endmodule
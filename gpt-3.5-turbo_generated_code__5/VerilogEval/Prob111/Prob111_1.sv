
module TopModule (
  input clk,
  input reset,
  input j,
  input k,
  output reg out
);

  reg [1:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b0;  // State OFF
    else
      case (state)
        2'b00: begin  // OFF
          if (j)
            state <= 2'b01;  // Transition to ON
        end
        2'b01: begin  // ON
          if (k)
            state <= 2'b00;  // Transition to OFF
        end
        default: state <= 2'b0;  // Default state to OFF
      endcase
    end
    
  always @(state) begin
    case (state)
      2'b00: out = 1'b0;  // OFF state
      2'b01: out = 1'b1;  // ON state
      default: out = 1'b0;  // Default to OFF state
    endcase
  end

endmodule
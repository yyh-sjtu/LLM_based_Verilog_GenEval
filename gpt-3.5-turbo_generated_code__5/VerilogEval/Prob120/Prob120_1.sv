
module TopModule (
    input  wire clk,
    input  wire reset,
    input  wire in,
    output wire out
);
  
  reg [1:0] state;
  reg out_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // Initialize state to A on reset
    else begin
      case (state)
        2'b00: begin
          if (in)
            state <= 2'b01; // Transition to B if input is 1
        else
            state <= 2'b00; // Stay in A if input is 0
        end
        
        2'b01: begin
          if (in)
            state <= 2'b01; // Stay in B if input is 1
          else
            state <= 2'b10; // Transition to C if input is 0
        end
        
        2'b10: begin
          if (in)
            state <= 2'b11; // Transition to D if input is 1
          else
            state <= 2'b00; // Transition to A if input is 0
        end
        
        2'b11: begin
          if (in)
            state <= 2'b01; // Transition to B if input is 1
          else
            state <= 2'b10; // Stay in D if input is 0
        end
      endcase
    end
  end
  
  always @(posedge clk) begin
    case (state)
      2'b00: out_reg <= 1'b0; // Output 0 in state A
      2'b01: out_reg <= 1'b0; // Output 0 in state B
      2'b10: out_reg <= 1'b0; // Output 0 in state C
      2'b11: out_reg <= 1'b1; // Output 1 in state D
    endcase
  end
  
  assign out = out_reg;
  
endmodule
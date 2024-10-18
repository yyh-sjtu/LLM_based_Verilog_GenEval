
module TopModule (
  input  in,
  input  [3:0] state,
  output [3:0] next_state,
  output out
);
  reg [3:0] next_state_reg;
  
  always @(*) begin
    case (state)
      4'b0001: begin
        next_state_reg = in ? 4'b0010 : 4'b0001;
        out = 1'b0;
      end
      4'b0010: begin
        next_state_reg = in ? 4'b0010 : 4'b0100;
        out = 1'b0;
      end
      4'b0100: begin
        next_state_reg = in ? 4'b1000 : 4'b0001;
        out = 1'b0;
      end
      4'b1000: begin
        next_state_reg = in ? 4'b0100 : 4'b0010;
        out = 1'b1;
      end
      default: begin
        next_state_reg = 4'bxxxx; // handle undefined state
        out = 1'bx; // handle undefined output
      end
    endcase
  end
  
  assign next_state = next_state_reg;
  
endmodule

module TopModule(
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output reg out
);

  // State transition and output logic
  always @(state, in) begin
    case(state)
      4'b0001: begin  // State A
        if(in) begin
          next_state = 4'b0010;  // Next state B if input is 1
          out = 1'b0;            // Output is 0
        end else begin
          next_state = 4'b0001;  // Next state A if input is 0
          out = 1'b0;            // Output is 0
        end
      end
  
      4'b0010: begin  // State B
        if(in) begin
          next_state = 4'b0010;  // Next state B if input is 1
          out = 1'b0;            // Output is 0
        end else begin
          next_state = 4'b0100;  // Next state C if input is 0
          out = 1'b0;            // Output is 0
        end
      end
  
      4'b0100: begin  // State C
        if(in) begin
          next_state = 4'b1000;  // Next state D if input is 1
          out = 1'b0;            // Output is 0
        end else begin
          next_state = 4'b0001;  // Next state A if input is 0
          out = 1'b0;            // Output is 0
        end
      end
  
      4'b1000: begin  // State D
        if(in) begin
          next_state = 4'b0010;  // Next state B if input is 1
          out = 1'b1;            // Output is 1
        end else begin
          next_state = 4'b0100;  // Next state C if input is 0
          out = 1'b0;            // Output is 0
        end
      end
    endcase
  end
endmodule
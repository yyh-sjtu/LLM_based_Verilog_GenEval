
module TopModule (
  input  wire [5:0] y,
  input  wire w,
  output wire Y1,
  output wire Y3
);

  // State flip-flop definitions
  reg [5:0] next_state;
  reg [5:0] current_state;
  
  always @ (posedge w) begin
    current_state <= next_state;
  end
  
  // State transition logic
  always @ (*) begin
    case (current_state)
      6'b000001: next_state = w ? 6'b000010 : 6'b000001;
      6'b000010: next_state = w ? 6'b000100 : 6'b001000;
      6'b000100: next_state = w ? 6'b010000 : 6'b001000;
      6'b001000: next_state = w ? 6'b100000 : 6'b000001;
      6'b010000: next_state = w ? 6'b010000 : 6'b001000;
      6'b100000: next_state = w ? 6'b000100 : 6'b001000;
      default: next_state = 6'b000001;
    endcase
  end
  
  // Output signal assignments
  assign {Y1, Y3} = {next_state[1], next_state[3]};
  
endmodule
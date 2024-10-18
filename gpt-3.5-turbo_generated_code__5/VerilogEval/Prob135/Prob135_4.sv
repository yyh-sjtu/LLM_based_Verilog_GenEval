
module TopModule (
  input [2:0] y,
  input w,
  output wire Y1
);

  // Declare internal signals and registers
  reg [2:0] next_state, current_state;
  wire [2:0] next_state;

  // Declare the output Y1
  assign Y1 = next_state[1];

  // Declare the state transition logic
  always @ (y or w) begin
    case (current_state)
      3'b000: next_state = w ? 3'b000 : 3'b001;
      3'b001: next_state = w ? 3'b001 : 3'b010;
      3'b010: next_state = w ? 3'b101 : 3'b010;
      3'b011: next_state = w ? 3'b010 : 3'b011;
      3'b100: next_state = w ? 3'b110 : 3'b011;
      3'b101: next_state = w ? 3'b011 : 3'b101;
    endcase
  end

  // Declare the sequential logic (flip-flop updates)
  always @(posedge clk) begin
    current_state <= next_state;
  end

endmodule
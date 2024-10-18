module fsm (
  input wire IN,
  input wire CLK,
  input wire RST,
  output wire MATCH
);

  reg [4:0] state;
  reg match;

  always @(posedge CLK or posedge RST) begin
    if (RST)
      state <= 0;
    else
      case (state)
        0: state <= IN ? 1 : 0;
        1: state <= IN ? 2 : 0;
        2: state <= IN ? 3 : 0;
        3: state <= IN ? 4 : 0;
        4: state <= IN ? 5 : 0;
        default: state <= 0;
      endcase
  end

  always @(state or IN) begin
    if (state == 5 && IN == 1)
      match = 1;
    else
      match = 0;
  end

  assign MATCH = match;

endmodule


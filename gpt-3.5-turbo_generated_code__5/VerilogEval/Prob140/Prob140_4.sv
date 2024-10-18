
module TopModule (
  input   clk,
  input   reset,
  input   in,
  output  disc,
  output  flag,
  output  err
);

  reg [2:0] state;
  reg       next_disc;
  
  always @(posedge clk)
  begin
    if (reset)
      state <= 3'b000;  // Reset state, behaves as though previous input was 0
    else
      state <= {state[1:0], in};
  end
  
  always @(state, in)
  begin
    next_disc = 0;
    
    case (state)
      3'b000: begin  // Initial state
                if (in)
                  state <= 3'b001;
              end
      3'b001: begin  // First consecutive 1s
                if (in)
                  state <= 3'b010;
                else
                  state <= 3'b000;
              end
      3'b010: begin  // 0111110 - Signal a bit needs to be discarded (disc)
                if (in)
                  state <= 3'b011;
                else
                  state <= 3'b000;
                next_disc = 1;
              end
      3'b011: begin  // Second consecutive 1s
                if (in)
                  state <= 3'b100;
                else
                  state <= 3'b000;
              end
      3'b100: begin  // 01111110 - Flag the beginning/end of a frame (flag)
                if (in)
                  state <= 3'b101;
                else
                  state <= 3'b000;
              end
      3'b101: begin  // Third consecutive 1s
                if (in)
                  state <= 3'b110;
                else
                  state <= 3'b000;
              end
      3'b110: begin  // 01111111... - Error (7 or more 1s) (err)
                if (in)
                  state <= 3'b110;
                else
                  state <= 3'b000;
              end
    endcase
  end
  
  assign disc = next_disc;
  assign flag = (state == 3'b100);
  assign err  = (state == 3'b110);

endmodule
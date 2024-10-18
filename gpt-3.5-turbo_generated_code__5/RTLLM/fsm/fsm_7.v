
module fsm (
  input wire IN,
  input wire CLK,
  input wire RST,
  output wire MATCH
);

  reg [1:0] state;
  reg MATCH_reg;
  reg IN_last;

  parameter [4:0] pattern = 5'b10011;

  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      MATCH_reg <= 0;
      state <= 0;
    end
    else begin
      IN_last <= IN;
      MATCH_reg <= MATCH_reg;
      state <= state;
      
      case(state)
        0: begin
          if (IN == 1'b1)
            state <= 1;
          else
            state <= 0;
        end
        1: begin
          if (IN == 1'b0)
            state <= 2;
          else
            state <= 0;
        end
        2: begin
          if (IN == 1'b0)
            state <= 3;
          else
            state <= 0;
        end
        3: begin
          if (IN == 1'b1)
            state <= 4;
          else
            state <= 0;
        end
        4: begin
          if (IN == 1'b1)
            state <= 1;
          else if (IN == 1'b0)
            state <= 5;
          else
            state <= 0;
        end
        5: begin
          if (IN == 1'b0)
            state <= 6;
          else
            state <= 0;
        end
        6: begin
          if (IN == 1'b0)
            state <= 7;
          else
            state <= 0;
        end
        7: begin
          if (IN == 1'b1)
            state <= 8;
          else
            state <= 0;
        end
        8: begin
          if (IN == 1'b1)
            state <= 1;
          else
            state <= 0;
        end
      endcase
    end
  end

  always @(state, IN_last) begin
    MATCH = (state == 4 && IN_last == 1'b1) || (state == 8 && IN_last == 1'b1);
    MATCH_reg = MATCH;
  end

endmodule
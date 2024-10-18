
module TopModule (
  input clk,
  input resetn,
  input [2:0] r,
  output reg [2:0] g
);

  reg [1:0] state, next_state;

  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;

  always @(posedge clk)
  begin
    if (!resetn) state <= A;
    else state <= next_state;
  end

  always @(state, r)
  begin
    case(state)
      A: begin
        if (r[0] && !r[1] && !r[2]) next_state = D;
        else if (r[0]) next_state = B;
        else if (!r[0] && r[1]) next_state = C;
        else next_state = A;
      end
      B: begin
        if (r[0]) next_state = B;
        else next_state = A;
      end
      C: begin
        if (r[1]) next_state = C;
        else next_state = A;
      end
      D: next_state = A;
    endcase
  end

  always @(posedge clk)
  begin
    if (!resetn) g <= 3'b000;
    else 
    begin
      case(state)
        A: g <= 3'b000;
        B: g <= 3'b001;
        C: g <= 3'b010;
        D: g <= 3'b100;
      endcase
    end
  end

endmodule
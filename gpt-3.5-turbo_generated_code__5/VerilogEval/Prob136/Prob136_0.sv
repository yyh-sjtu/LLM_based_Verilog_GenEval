
module TopModule (
  input  clk,
  input  reset,
  input  w,
  output z
);
  
  enum logic [2:0] states = '{A, B, C, D, E, F};
  logic [2:0] current_state;
  logic [2:0] next_state;
  
  always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
  end
  
  always_comb begin
    case (current_state)
      A:
        if (w) begin
          next_state = A;
        end else begin
          next_state = B;
        end
      B:
        if (w) begin
          next_state = D;
        end else begin
          next_state = C;
        end
      C:
        if (w) begin
          next_state = D;
        end else begin
          next_state = E;
        end
      D:
        if (w) begin
          next_state = A;
        end else begin
          next_state = F;
        end
      E:
        if (w) begin
          next_state = D;
        end else begin
          next_state = E;
        end
      F:
        if (w) begin
          next_state = D;
        end else begin
          next_state = C;
        end
      default:
        next_state = A;
    endcase
  end
  
  assign z = (current_state == E) ? 1'b1 : 1'b0;
  
endmodule
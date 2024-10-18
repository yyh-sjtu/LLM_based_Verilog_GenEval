
module TopModule(
  input clk,
  input reset,
  input in,
  output reg out
);

  reg [1:0] state, next_state;

  parameter S_A = 2'b00;
  parameter S_B = 2'b01;
  parameter S_C = 2'b10;
  parameter S_D = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= S_A;
    end else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      S_A: begin
        if (in) begin
          next_state = S_B;
        end else begin
          next_state = S_A;
        end
        out = 1'b0;
      end
      S_B: begin
        if (in) begin
          next_state = S_B;
        end else begin
          next_state = S_C;
        end
        out = 1'b0;
      end
      S_C: begin
        if (in) begin
          next_state = S_D;
        end else begin
          next_state = S_A;
        end
        out = 1'b0;
      end
      S_D: begin
        if (in) begin
          next_state = S_B;
        end else begin
          next_state = S_C;
        end
        out = 1'b1;
      end
    endcase
  end

endmodule
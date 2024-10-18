
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  // FSM states
  localparam A = 2'b00;
  localparam B = 2'b01;
  localparam C = 2'b10;
  localparam D = 2'b11;

  reg [1:0] state;
  reg [2:0] x_history;

  always @(posedge clk) begin
    if (!resetn) begin
      state <= A;
      f <= 0;
      g <= 0;
      x_history <= 3'b000;
    end else begin
      case (state)
        A:
          if (resetn)
            state <= B;
        B:
          begin
            f <= 1;
            state <= C;
          end
        C:
          begin
            x_history <= {x_history[1:0], x};
            if (x_history == 3'b101)
              state <= D;
          end
        D:
          begin
            if (y == 1)
              state <= D;
            else if (y == 0)
              begin
                state <= A;
                g <= 0;
              end
          end
      endcase
    end
  end

endmodule
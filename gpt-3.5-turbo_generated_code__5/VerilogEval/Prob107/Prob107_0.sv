
module TopModule (
  input  clk,
  input  reset,
  input  in,
  output out
);

  reg [1:0] state;
  reg out;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b10; // B state
      out <= 1'b1; // initial output value in B state
    end else begin
      case (state)
        2'b00: begin // A state
          if (in)
            state <= 2'b00; // remain in A state
          else
            state <= 2'b01; // transition to B state
        end
        2'b01: begin // B state
          if (in)
            state <= 2'b01; // remain in B state
          else
            state <= 2'b10; // transition to A state
        end
      endcase
    end
  end

  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
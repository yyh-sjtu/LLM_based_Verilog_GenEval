
module TopModule(
  input  clk,
  input  reset,
  input  s,
  input  w,
  output reg z
);

  reg [1:0] state;
  reg [2:0] w_count;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;
      w_count <= 3'b000;
      z <= 1'b0;
    end else begin
      case (state)
        2'b00: begin // State A
          if (s) begin
            state <= 2'b01; // Transition to state B
            w_count <= 3'b000;
          end
        end
        2'b01: begin // State B
          w_count <= {w_count[1:0], w}; // Shift in w value
  
          if (w_count == 3'b011)  // Check for two 1's in three clock cycles
            z <= 1'b1;
          else if (w_count == 3'b100)
            z <= 1'b0;  
  
          state <= 2'b01; // Stay in state B
        end
      endcase
    end
  end

endmodule
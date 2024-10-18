
module TopModule (
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  // Declare the state variable
  reg [3:0] state;

  // Assign the initial state
  initial begin
    state = 4'b0000;
  end

  // State machine
  always @(posedge clk) begin
    if (reset) begin
      state <= 4'b0000;
      start_shifting <= 0;
    end else begin
      case (state)
        4'b0000: begin // State 0
          if (data) begin
            state <= 4'b0001;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0001: begin // State 1
          if (data) begin
            state <= 4'b0011;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0011: begin // State 2
          if (data) begin
            state <= 4'b0111;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0111: begin // State 3
          if (data) begin
            start_shifting <= 1;
            state <= 4'b1111;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b1111: begin // State 4
          if (reset) begin
            start_shifting <= 0;
            state <= 4'b0000;
          end else begin
            state <= 4'b1111;
          end
        end
        default: state <= 4'b0000;
      endcase
    end
  end

endmodule
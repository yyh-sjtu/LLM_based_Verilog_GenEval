
module TopModule (
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  // Internal state variables
  reg [3:0] state;
  reg [3:0] next_state;

  // State encoding
  parameter START = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0100;
  parameter FOUND = 4'b1000;

  always @(posedge clk) begin
    if (reset) begin
      state <= START;
      start_shifting <= 0;
    end else begin
      state <= next_state;
      start_shifting <= (state == FOUND);
    end
  end

  always @(*) begin
    case (state)
      START: begin
        if (data == 1'b1)
          next_state = S1;
        else
          next_state = START;
      end
      S1: begin
        if (data == 1'b1)
          next_state = S1;
        else
          next_state = S2;
      end
      S2: begin
        if (data == 1'b1)
          next_state = S3;
        else
          next_state = START;
      end
      S3: begin
        if (data == 1'b1)
          next_state = FOUND;
        else
          next_state = START;
      end
      FOUND: begin
        next_state = FOUND;
      end
      default: begin
        next_state = START;
      end
    endcase
  end

endmodule
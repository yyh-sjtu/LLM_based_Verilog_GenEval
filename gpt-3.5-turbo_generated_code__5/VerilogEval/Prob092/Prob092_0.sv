
module TopModule (
  input [99:0] in,
  output reg [99:0] out_both,
  output reg [99:0] out_any,
  output reg [99:0] out_different
);

  reg [99:0] in_left_shifted;
  reg [99:0] in_right_shifted;

  // Shift the input vector by 1 to the left
  always @(*) begin
    in_left_shifted[0] = in[99];
    for (int i = 1; i < 100; i = i + 1) begin
      in_left_shifted[i] = in[i-1];
    end
  end

  // Shift the input vector by 1 to the right
  always @(*) begin
    in_right_shifted[99] = in[0];
    for (int i = 0; i < 99; i = i + 1) begin
      in_right_shifted[i] = in[i+1];
    end
  end

  // Calculate out_both
  always @(posedge clk) begin
    for (int i = 0; i < 100; i = i + 1) begin
      if (i == 0) begin
        out_both[i] = 0;
      else if (in[i] == 1'b1 && in_left_shifted[i] == 1'b1)
        out_both[i] = 1'b1;
      else
        out_both[i] = 1'b0;
    end
  end

  // Calculate out_any
  always @(posedge clk) begin
    for (int i = 0; i < 100; i = i + 1) begin
      if (i == 99) begin
        out_any[i] = 0;
      else if (in[i] == 1'b1 || in_right_shifted[i] == 1'b1)
        out_any[i] = 1'b1;
      else
        out_any[i] = 1'b0;
    end
  end

  // Calculate out_different
  always @(posedge clk) begin
    for (int i = 0; i < 100; i = i + 1) begin
      if (in[i] == in_left_shifted[i])
        out_different[i] = 1'b0;
      else
        out_different[i] = 1'b1;
    end
  end

endmodule
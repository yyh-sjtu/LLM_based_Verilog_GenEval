module left_rotate(
  input clk,
  input reset,
  input [2:0] amount,
  input [7:0] data,
  input load,
  output reg [7:0] out
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out <= 0;
    end else if (load) begin
      out <= data;
    end else begin
      out <= {data[amount - 1:0], data[7:amount]};
    end
  end

endmodule


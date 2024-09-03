module full_adder(
  input a,
  input b,
  input cin,
  output reg sum,
  output reg cout
);

always @(*) begin
  sum = a ^ b ^ cin;
  cout = (a & b) | (cin & (a ^ b));
end

endmodule

module left_rotate(
  input clk,
  input reset,
  input [2:0] amount,
  input [7:0] data,
  input load,
  output reg [7:0] out
);

reg [7:0] rotated_data;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    rotated_data <= 8'b0;
  end else begin
    if (load) begin
      rotated_data <= data << amount;
    end else begin
      rotated_data <= rotated_data << amount;
    end
  end
end

assign out = rotated_data;

endmodule

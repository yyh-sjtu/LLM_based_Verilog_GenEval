
module TopModule (
  input  wire clk,
  input  wire reset,
  output wire [3:0] ena,
  output wire [15:0] q
);

  reg [15:0] count;

  always @(posedge clk) begin
    if (reset == 1) begin
      count <= 0;
    end else begin
      if (count == 9'b1001100110011001) begin
        count <= 0;
      end else begin
        count <= count + 1;
      end
    end
  end

  assign q[3:0] = count[3:0];
  assign q[7:4] = count[7:4];
  assign q[11:8] = count[11:8];
  assign q[15:12] = count[15:12];

  assign ena[3] = (count[3:0] == 4'b0111);
  assign ena[2] = (count[7:4] == 4'b0111);
  assign ena[1] = (count[11:8] == 4'b0111);
  assign ena[0] = (count[15:12] == 4'b0111);

endmodule
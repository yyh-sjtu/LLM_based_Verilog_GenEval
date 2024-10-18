
module parallel2serial (
  input clk,
  input rst_n,
  input [3:0] d,
  output valid_out,
  output dout
);

  reg [2:0] cnt;
  reg [3:0] data;
  reg valid;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      cnt <= 0;
      data <= 0;
      valid <= 0;
    end
    else begin
      if (cnt == 3) begin
        valid <= 1;
        data <= d;
        cnt <= 0;
      end
      else begin
        valid <= 0;
        cnt <= cnt + 1;
        data[3:1] <= data[2:0];
      end
    end
  end

  assign valid_out = valid;
  assign dout = data[3];

endmodule
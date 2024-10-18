
module serial2parallel (
  input wire clk,
  input wire rst_n,
  input wire din_serial,
  input wire din_valid,
  output reg [7:0] dout_parallel,
  output reg dout_valid
);

  reg [3:0] cnt;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      cnt <= 0;
      dout_parallel <= 0;
      dout_valid <= 0;
    end
    else begin
      if (din_valid) begin
        if (cnt < 7) begin
          dout_parallel <= {din_serial, dout_parallel[7:1]};
          cnt <= cnt + 1;
        end
        else begin
          dout_parallel <= {din_serial, dout_parallel[7:1]};
          dout_valid <= 1;
          cnt <= 0;
        end
      end
    end
  end

endmodule
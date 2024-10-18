
module parallel2serial (
  input wire clk,
  input wire rst_n,
  input wire [3:0] d,
  output wire valid_out,
  output wire dout
);

  reg [2:0] cnt;
  reg [3:0] data;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      cnt <= 0;
      data <= 0;
      valid_out <= 0;
      dout <= 0;
    end
    
    else begin
      if (cnt == 3) begin
        data <= d;
        cnt <= 0;
        valid_out <= 1;
        dout <= data[3];
      end
      
      else begin
        cnt <= cnt + 1;
        valid_out <= 0;
        data <= {data[2:0], d[3]};
        dout <= data[3];
      end
    end
  end

endmodule
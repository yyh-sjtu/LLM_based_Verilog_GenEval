
module width_8to16 (
  input wire clk,
  input wire rst_n,
  input wire valid_in,
  input wire [7:0] data_in,
  output wire valid_out,
  output wire [15:0] data_out
);

  reg [7:0] data_lock;
  reg [15:0] data_out_reg;
  reg flag;
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out_reg <= 16'b0;
      flag <= 1'b0;
    end else begin
      if (valid_in) begin
        flag <= ~flag;
        if (flag) begin
          data_lock <= data_in;
        end else begin
          data_out_reg <= {data_lock, data_in};
        end
      end
    end
  end
  
  assign valid_out = flag;
  assign data_out = data_out_reg;

endmodule
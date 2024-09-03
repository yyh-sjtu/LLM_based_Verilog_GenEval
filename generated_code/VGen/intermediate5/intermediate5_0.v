
module left_rotate(
  input clk,
  input reset,
  input [2:0] amount,
  input [7:0] data,
  input load,
  output reg [7:0] out
);

  reg [7:0] temp;
  
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      out <= 8'b0;
      temp <= 8'b0;
    end else begin
      if(load) begin
        temp <= data;
        out <= temp;
      end else begin
        temp <= {temp[6:0], temp[7]};
        out <= temp;
      end
    end
  end
endmodule
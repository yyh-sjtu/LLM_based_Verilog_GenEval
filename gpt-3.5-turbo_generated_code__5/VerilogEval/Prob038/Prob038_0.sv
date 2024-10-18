
module TopModule (
  input  clk,
  input  reset,
  output [3:0] q
);
  
  reg [3:0] count;
  
  always @(posedge clk) begin
    if (reset) begin
      count <= 4'b0;
    end else begin
      if (count == 4'b1111) begin
        count <= 4'b0;
      end else begin
        count <= count + 4'b1;
      end
    end
  end
  
  assign q = count;
  
endmodule
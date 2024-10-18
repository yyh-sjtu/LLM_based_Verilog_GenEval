module TopModule (
  input clk,
  input reset,
  output reg [3:0] ena,
  output reg [15:0] q
);
  
  reg [15:0] counter;

  always @(posedge clk) begin
    if (reset) begin
      counter <= 0;
      ena <= 4'b0000;
    end
    else begin
      if (counter == 9) begin
        counter <= 0;
        ena <= ena + 4'b0001;
      end
      else begin
        counter <= counter + 1;
        ena <= ena;
      end
    end
  end
  
  assign q = {counter[3:0], counter[7:4], counter[11:8], counter[15:12]};
  
endmodule


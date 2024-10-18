
module TopModule (
  input clk,
  input reset,
  input slowena,
  output reg [3:0] q
);

  reg [3:0] counter;

  always @(posedge clk) begin
    if (reset) begin
      counter <= 4'h0;
    end else if (slowena) begin
      // Check if counter has reached 9
      if (counter == 4'h9) begin
        counter <= 4'h0;
      end else begin
        counter <= counter + 1;
      end
    end
  end

  assign q = counter;

endmodule
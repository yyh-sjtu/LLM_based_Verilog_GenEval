
module TopModule (
  input  wire clk,
  input  wire reset,
  output wire [9:0] q
);

  reg [9:0] counter;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 0;
    end else begin
      if (counter == 999) begin
        counter <= 0;
      end else begin
        counter <= counter + 1;
      end
    end
  end

  assign q = counter;

endmodule
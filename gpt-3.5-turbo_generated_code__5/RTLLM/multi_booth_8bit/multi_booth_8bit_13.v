
module multi_booth_8bit (
  input wire clk,
  input wire reset,
  input wire [7:0] a,
  input wire [7:0] b,
  output wire [15:0] p,
  output wire rdy
);

  reg [7:0] multiplier;
  reg [7:0] multiplicand;
  reg [4:0] ctr;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      multiplier <= {{8{a[7]}}, a};
      multiplicand <= {{8{b[7]}}, b};
      ctr <= 0;
      rdy <= 0;
    end else begin
      if (ctr < 16) begin
        multiplicand <= multiplicand << 1;
        if (multiplier[ctr]) begin
          p <= p + multiplicand;
        end
        ctr <= ctr + 1;
      end else begin
        rdy <= 1;
      end
    end
  end

endmodule
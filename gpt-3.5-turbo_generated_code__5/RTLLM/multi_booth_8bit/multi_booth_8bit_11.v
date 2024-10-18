
module multi_booth_8bit (
  input wire clk,
  input wire reset,
  input wire [7:0] a,
  input wire [7:0] b,
  output wire [15:0] p,
  output wire rdy
);

  reg [7:0] multiplicand;
  reg [7:0] multiplier;
  reg [15:0] p_reg;
  reg [4:0] ctr;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      multiplier <= {{8{a[7]}}, a};
      multiplicand <= {{8{b[7]}}, b};
      ctr <= 0;
      p_reg <= 0;
      rdy <= 0;
    end
    else begin
      if (ctr < 16) begin
        multiplicand <= {multiplicand[6:0], multiplicand[7]};
        ctr <= ctr + 1;
        
        if (multiplier[ctr] == 1) begin
          p_reg <= p_reg + multiplicand;
        end
      end
      else begin
        rdy <= 1;
      end
    end
  end
  
  assign p = p_reg;
  
endmodule
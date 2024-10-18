
module multi_booth_8bit (
  input wire clk,       // Clock signal
  input wire reset,     // Reset signal
  input wire [7:0] a,   // 8-bit multiplicand
  input wire [7:0] b,   // 8-bit multiplier
  output wire [15:0] p, // 16-bit product
  output wire rdy       // Ready signal
);
  
  reg [7:0] multiplicand;   // Multiplicand register
  reg [15:0] multiplier;    // Multiplier register
  reg [4:0] ctr;            // Counter
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin         // Reset operation
      multiplier <= {{8{1'b0}}, a};
      multiplicand <= {{8{1'b0}}, b};
      ctr <= 5'b0;
      rdy <= 1'b0;
    end
    else begin              // Normal operation
      if (ctr < 5'd15) begin
        multiplicand <= multiplicand << 1;
        if (multiplier[ctr] == 1'b1) begin
          p <= p + multiplicand;
        end
        ctr <= ctr + 1;
      end
      else begin
        rdy <= 1'b1;
      end
    end
  end

endmodule
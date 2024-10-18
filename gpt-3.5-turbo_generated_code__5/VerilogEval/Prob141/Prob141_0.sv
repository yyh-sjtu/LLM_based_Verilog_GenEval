
module TopModule(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  always @(posedge clk) begin
    if (reset) begin
      // Reset the clock to 12:00 AM
      pm <= 0;
      hh <= 8'b00010010;  // BCD representation for 12
      mm <= 8'b00000000;  // BCD representation for 0
      ss <= 8'b00000000;  // BCD representation for 0
    end else begin
      if (ena) begin
        // Increment the clock by 1 second
        ss <= ss + 1;
      end
      
      // Check for seconds overflow
      if (ss >= 8'b01101000) begin  // BCD representation for 60
        ss <= 8'b00000000;  // Reset seconds to 00
        mm <= mm + 1;  // Increment minutes
        
        // Check for minutes overflow
        if (mm >= 8'b01100000) begin  // BCD representation for 60
          mm <= 8'b00000000;  // Reset minutes to 00
          
          // Increment hours
          hh <= hh + 1;
          
          // Check for hours overflow (12 hour clock)
          if (hh >= 8'b00011010) begin  // BCD representation for 13
            hh <= 8'b00010010;  // Reset hours to 12
            pm <= ~pm;  // Toggle AM/PM indicator
          end
        end
      end
    end
  end

endmodule
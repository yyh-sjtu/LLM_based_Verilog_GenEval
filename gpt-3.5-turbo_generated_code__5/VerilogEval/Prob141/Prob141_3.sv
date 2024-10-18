
module TopModule(
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [7:0] hour_count;
  reg [7:0] minute_count;
  reg [7:0] second_count;

  always @(posedge clk) begin
    if (reset) begin
      // Reset the clock to "12:00 AM"
      hour_count <= 8'b0001;   // 01
      minute_count <= 8'b0000; // 00
      second_count <= 8'b0000; // 00
    end else if (ena) begin
      // Increment the clock once per second
      second_count <= second_count + 1;
  
      if (second_count == 8'b0110) begin
        // 60 seconds reached, reset seconds and increment minutes
        second_count <= 8'b0000; // 00
        minute_count <= minute_count + 1;

        if (minute_count == 8'b1010) begin
          // 10 minutes reached, reset minutes and increment hours
          minute_count <= 8'b0000; // 00
          hour_count <= hour_count + 1;

          if (hour_count == 8'b1100) begin
            // 12 hours reached, reset hours and toggle AM/PM
            hour_count <= 8'b0001; // 01
            pm <= ~pm;
          end
        end
      end
    end
  end

  // Output BCD (Binary- Coded Decimal) representation of hour, minute, and second
  assign hh = {4{pm}}, hour_count;
  assign mm = minute_count;
  assign ss = second_count;

endmodule
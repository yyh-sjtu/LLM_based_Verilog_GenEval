module top_module (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [27:0] counter;

  always @(posedge clk) begin
    if (reset) begin
      pm <= 0;
      hh <= 8'b0001;
      mm <= 8'b0000;
      ss <= 8'b0000;
      counter <= 28'b0;
    end else if (ena) begin
      if (counter >= 59999999) begin
        ss <= ss + 1;
        counter <= 0;
        if (ss >= 59) begin
          ss <= 0;
          mm <= mm + 1;
          if (mm >= 59) begin
            mm <= 0;
            hh <= hh + 1;
            if (hh >= 12) begin
              hh <= 8'b0001;
              if (pm) begin
                pm <= 0;
              end else begin
                pm <= 1;
              end
            end
          end
        end
      end else begin
        counter <= counter + 1;
      end
    end
  end

endmodule


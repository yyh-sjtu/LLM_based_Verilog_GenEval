
module calendar (
  input CLK,
  input RST,
  output reg [5:0] Hours,
  output reg [5:0] Mins,
  output reg [5:0] Secs
);
  
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      Secs <= 6'b0;
    end else if (Secs == 6'd59) begin
      Secs <= 6'b0;
    end else begin
      Secs <= Secs + 1;
    end
  end
  
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      Mins <= 6'b0;
    end else if ((Secs == 6'd59) && (Mins == 6'd59)) begin
      Mins <= 6'b0;
    end else if (Secs == 6'd59) begin
      Mins <= Mins + 1;
    end
  end
  
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      Hours <= 6'b0;
    end else if ((Secs == 6'd59) && (Mins == 6'd59) && (Hours == 6'd23)) begin
      Hours <= 6'b0;
    end else if ((Mins == 6'd59) && (Secs == 6'd59)) begin
      Hours <= Hours + 1;
    end
  end
  
endmodule
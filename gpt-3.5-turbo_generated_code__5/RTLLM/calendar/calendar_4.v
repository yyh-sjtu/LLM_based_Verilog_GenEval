
module calendar(
  input CLK,
  input RST,
  output reg [5:0] Hours,
  output reg [5:0] Mins,
  output reg [5:0] Secs
);

  always @(posedge CLK or posedge RST) begin
    if(RST)
      Secs <= 0;
    else if(Secs == 59)
      Secs <= 0;
    else
      Secs <= Secs + 1;
  end

  always @(posedge CLK or posedge RST) begin
    if(RST)
      Mins <= 0;
    else if(Secs == 59 && Mins == 59)
      Mins <= 0;
    else if(Secs == 59)
      Mins <= Mins + 1;
  end

  always @(posedge CLK or posedge RST) begin
    if(RST)
      Hours <= 0;
    else if(Secs == 59 && Mins == 59 && Hours == 23)
      Hours <= 0;
    else if(Mins == 59 && Secs == 59)
      Hours <= Hours + 1;
  end

endmodule